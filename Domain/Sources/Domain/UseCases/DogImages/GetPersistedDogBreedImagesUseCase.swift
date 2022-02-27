//
//  File.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation

public protocol GetPersistedDogBreedImagestUseCaseContract {
    func execute(dogBreedName: String) -> [BreedImage]
}

public final class GetPersistedDogBreedImagesUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - GetPersistedDogBreedImagestUseCaseContract
extension GetPersistedDogBreedImagesUseCase: GetPersistedDogBreedImagestUseCaseContract {
    public func execute(dogBreedName: String) -> [BreedImage] {
        dogBreedsPersistedProvider.getImagesOfBreed(dogBreedName)
    }
}
