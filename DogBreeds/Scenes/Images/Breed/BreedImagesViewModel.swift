//
//  BreedImagesViewModel.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation
import Injector
import Combine
import Domain

@MainActor final class BreedImagesViewModel: ObservableObject {
    @Injected private var fetchDogImagesFromRemoteOrLocaUseCase: FetchDogImagesFromRemoteOrLocalUseCaseContract
    
    private let breedName: String
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var viewState = ViewState.loading
    
    // MARK: - Initializer
    init(breedName: String) {
        self.breedName = breedName
    }
}

// MARK: - ViewState
extension BreedImagesViewModel {
    enum ViewState: Equatable {
        case loading
        case error
        case render([BreedImage])
        
        mutating func toggleLikeStatus(image: BreedImage) {
            guard case var .render(images) = self,
                  let index = images.firstIndex(of: image) else {
                      return
                      
                  }
            
            images[index].isFavorite.toggle()
            self = .render(images)
        }
    }
}

// MARK: - Private methods
private extension BreedImagesViewModel {
    private func getDogBreedImages() async {
        viewState = .loading
        do {
            let breedImages = try await fetchDogImagesFromRemoteOrLocaUseCase.execute(dogBreedName: breedName)
            viewState = .render(breedImages)
        } catch {
            viewState = .error
        }
    }
}

// MARK: - Public method
extension BreedImagesViewModel {
    struct Input {
        let retryButtonTapPublisher: AnyPublisher<Void, Never>
        let likeButtonTapPublisher: AnyPublisher<BreedImage, Never>
    }
    
    func bind(_ input: Input) async {
        await getDogBreedImages()
        
        observeRetryButtonTapPublisher(input.retryButtonTapPublisher)
        observeLikeButtonTapPublisher(input.likeButtonTapPublisher)
    }
}

// MARK: - Observe methods
private extension BreedImagesViewModel {
    private func observeRetryButtonTapPublisher(_ publisher: AnyPublisher<Void, Never>) {
        publisher
            .sink { _ in
                Task {
                    await self.getDogBreedImages()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func observeLikeButtonTapPublisher(_ publisher: AnyPublisher<BreedImage, Never>) {
        publisher
            .sink { [weak self] image in
                self?.viewState.toggleLikeStatus(image: image)
            }
            .store(in: &subscriptions)
    }
}
