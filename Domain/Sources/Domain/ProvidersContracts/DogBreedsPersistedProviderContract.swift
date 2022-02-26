//
//  DogBreedsPersistedProviderContract.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public enum DogBreedsPersistedProviderError: Error {
    case general
    case notFound
}

public protocol DogBreedsPersistedProviderContract {
    func fetchDogBreeds() -> [DogBreed]
    func fetchDogBreedsCount() -> Int
    func storeDogBreeds(from dictionary: [String: [String]]) throws
    func updateDogBreed(_ dogBreed: String, images: [String]) throws
    func toggleDogBreedImageFavoriteStatus(_ image: String) throws
}
