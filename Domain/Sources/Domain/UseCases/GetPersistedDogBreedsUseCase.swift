//
//  GetPersistedDogBreedsUseCase.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public protocol GetPersistedDogBreedsUseCaseContract {
    func execute() -> [DogBreed]
}

public final class GetPersistedDogBreedsUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - GetPersistedDogBreedsUseCaseContract
extension GetPersistedDogBreedsUseCase: GetPersistedDogBreedsUseCaseContract {
    public func execute() -> [DogBreed] {
        dogBreedsPersistedProvider.fetchDogBreeds()
    }
}
