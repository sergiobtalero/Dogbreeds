//
//  File.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public protocol StoreDogBreedsUseCaseContract {
    func execute(dictionary: [String: [String]]) throws
}

public final class StoreDogBreedsUseCase {
    private let provider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(provider: DogBreedsPersistedProviderContract) {
        self.provider = provider
    }
}

// MARK: - DogBreedsPersistedProviderContract
extension StoreDogBreedsUseCase: StoreDogBreedsUseCaseContract {
    public func execute(dictionary: [String : [String]]) throws {
        try provider.storeDogBreeds(from: dictionary)
    }
}
