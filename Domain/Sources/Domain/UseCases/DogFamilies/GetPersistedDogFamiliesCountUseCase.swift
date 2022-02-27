//
//  GetPersistedDogbreedsCountUseCase.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

public protocol GetPersistedDogFamiliesCountUseCaseContract {
    func execute() -> Int
}

public final class GetPersistedDogFamiliesCountUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - GetPersistedDogBreedsCountUseCaseContract
extension GetPersistedDogFamiliesCountUseCase: GetPersistedDogFamiliesCountUseCaseContract {
    public func execute() -> Int {
        dogBreedsPersistedProvider.fetchDogBreedsCount()
    }
}
