//
//  GetPersistedDogBreedsUseCase.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public protocol GetPersistedDogFamiliesUseCaseContract {
    func execute() -> [DogFamily]
}

public final class GetPersistedDogFamiliesUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - GetPersistedDogBreedsUseCaseContract
extension GetPersistedDogFamiliesUseCase: GetPersistedDogFamiliesUseCaseContract {
    public func execute() -> [DogFamily] {
        dogBreedsPersistedProvider.fetchDogFamilies()
    }
}
