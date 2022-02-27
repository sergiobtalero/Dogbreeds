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
    func fetchDogFamilies() -> [DogFamily]
    func fetchDogfamiliy(name: String) throws -> DogFamily
    func fetchDogBreedsCount() -> Int
    func storeDogBreeds(from dictionary: [String: [String]])
    func getImagesOfBreed(_ dogBreed: String) -> [BreedImage]
    func getImagesCountOfBreed(_ dogBreed: String) -> Int
    func addImages(_ images: [String], dogBreedName: String) throws
    func addImages(_ images: [String], dogFamilyName: String) throws
    func toggleDogBreedImageFavoriteStatus(_ image: String) throws
    func getFavoritedImages() -> [BreedImage]
}
