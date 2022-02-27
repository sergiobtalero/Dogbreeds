//
//  GetPersistedDogBreedImagesCountUseCase.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation

public protocol GetPersistedDogBreedImagesCountUseCaseContract {
    func execute(dogBreedName: String) -> Int
}

public final class GetPersistedDogBreedImagesCountUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - GetPersistedDogBreedImagesCountUseCaseContract
extension GetPersistedDogBreedImagesCountUseCase: GetPersistedDogBreedImagesCountUseCaseContract {
    public func execute(dogBreedName: String) -> Int {
        dogBreedsPersistedProvider.getImagesCountOfBreed(dogBreedName)
    }
}
