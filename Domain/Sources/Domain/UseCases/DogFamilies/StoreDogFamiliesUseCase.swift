//
//  File.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public protocol StoreDogFamiliesUseCaseContract {
    func execute(dictionary: [String: [String]]) throws
}

public final class StoreDogFamiliesUseCase {
    private let provider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(provider: DogBreedsPersistedProviderContract) {
        self.provider = provider
    }
}

// MARK: - DogBreedsPersistedProviderContract
extension StoreDogFamiliesUseCase: StoreDogFamiliesUseCaseContract {
    public func execute(dictionary: [String : [String]]) throws {
        provider.storeDogBreeds(from: dictionary)
    }
}
