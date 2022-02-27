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
    enum ViewState {
        case loading
        case error
        case render([BreedImage])
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
    }
    
    func bind(_ input: Input) async {
        await getDogBreedImages()
        
        input.retryButtonTapPublisher
            .sink { _ in
                Task {
                    await self.getDogBreedImages()
                }
            }
            .store(in: &subscriptions)
    }
}
