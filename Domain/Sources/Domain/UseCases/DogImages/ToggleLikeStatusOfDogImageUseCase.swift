//
//  ToggleLikeStatusOfDogImageUseCase.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation

public protocol ToggleLikeStatusOfDogImageUseCaseContract {
    func execute(breedImage: BreedImage) throws
}

public final class ToggleLikeStatusOfDogImageUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - ToggleLikeStatusOfDogImageUseCaseContract
extension ToggleLikeStatusOfDogImageUseCase: ToggleLikeStatusOfDogImageUseCaseContract {
    public func execute(breedImage: BreedImage) throws {
        try dogBreedsPersistedProvider.toggleDogBreedImageFavoriteStatus(breedImage.url.absoluteString)
    }
}
