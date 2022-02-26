//
//  DogBreedsPersistedProviderContract.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public enum DogBreedsPersistedProviderError: Error {
    case general
}

public protocol DogBreedsPersistedProviderContract {
    func fetchDogBreeds() -> [DogBreed]
    func fetchDogBreedsCount() -> Int
    func storeDogBreeds(from dictionary: [String: [String]]) throws
}
