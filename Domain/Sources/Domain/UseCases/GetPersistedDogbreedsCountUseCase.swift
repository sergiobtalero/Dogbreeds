//
//  GetPersistedDogbreedsCountUseCase.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

public protocol GetPersistedDogBreedsCountUseCaseContract {
    func execute() -> Int
}

public final class GetPersistedDogbreedsCountUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - GetPersistedDogBreedsCountUseCaseContract
extension GetPersistedDogbreedsCountUseCase: GetPersistedDogBreedsCountUseCaseContract {
    public func execute() -> Int {
        dogBreedsPersistedProvider.fetchDogBreedsCount()
    }
}
