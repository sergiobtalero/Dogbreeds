//
//  FavoritesViewModel.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation
import Injector
import Combine
import Domain

@MainActor final class FavoritesViewModel: ObservableObject {
    @Injected private var getFavoritedImagesUseCase: GetFavoritedImagesUseCaseContract
    @Injected private var toggleLikeStatusOfDogImageUseCase: ToggleLikeStatusOfDogImageUseCaseContract
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var viewState = ViewState.empty
}

// MARK: - View State
extension FavoritesViewModel {
    enum ViewState: Equatable {
        case empty
        case render([BreedImage])
        
        mutating func toggleFavoriteStatus(image: BreedImage) {
            guard case var .render(images) = self,
                  let index = images.firstIndex(of: image) else {
                      return
                  }
            
            images.remove(at: index)
            self = images.isEmpty ? .empty : .render(images)
        }
    }
}

// MARK: - Private methods
private extension FavoritesViewModel {
    private func loadData() {
        let images = getFavoritedImagesUseCase.execute()
        Task { @MainActor in
            viewState = images.isEmpty ? .empty : .render(images)
        }
    }
    
    private func toggleFavoriteStatus(breedImage: BreedImage) {
        do {
            try toggleLikeStatusOfDogImageUseCase.execute(breedImage: breedImage)
            viewState.toggleFavoriteStatus(image: breedImage)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Public methods
extension FavoritesViewModel {
    struct Input {
        let toggleFavoritedStatusOfImagePublisher: AnyPublisher<BreedImage, Never>
    }
    
    func bind(_ input: Input) {
        loadData()
        
        observeToggleFavoritedStatusOfImagePublisher(input.toggleFavoritedStatusOfImagePublisher)
    }
}

// MARK: - Observe methods
private extension FavoritesViewModel {
    private func observeToggleFavoritedStatusOfImagePublisher(_ publisher: AnyPublisher<BreedImage, Never>) {
        publisher
            .sink { [weak self] breedImage in
                self?.toggleFavoriteStatus(breedImage: breedImage)
            }
            .store(in: &subscriptions)
    }
}
