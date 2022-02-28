//
//  MockDogBreedsPersistedProvider.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import Foundation

class MockDogBreedsPersistedProvider: DogBreedsPersistedProviderContract {
    let error: Error?
    let dogFamilies: [DogFamily]
    let breedImages: [BreedImage]
    
    init(error: Error? = nil, dogFamilies: [DogFamily] = [], breedImages: [BreedImage] = []) {
        self.error = error
        self.dogFamilies = dogFamilies
        self.breedImages = breedImages
    }
    
    func fetchDogFamilies() -> [DogFamily] {
        dogFamilies
    }
    
    func fetchDogfamiliy(name: String) throws -> DogFamily {
        if let error = error {
            throw error
        }
        return dogFamilies.first!
    }
    
    func fetchDogBreedsCount() -> Int {
        dogFamilies.count
    }
    
    func storeDogBreeds(from dictionary: [String : [String]]) {
        
    }
    
    func getImagesOfBreed(_ dogBreed: String) -> [BreedImage] {
        breedImages
    }
    
    func getImagesCountOfBreed(_ dogBreed: String) -> Int {
        breedImages.count
    }
    
    func addImages(_ images: [String], dogBreedName: String) throws {
        if let error = error {
            throw error
        }
    }
    
    func addImages(_ images: [String], dogFamilyName: String) throws {
        if let error = error {
            throw error
        }
    }
    
    func toggleDogBreedImageFavoriteStatus(_ image: String) throws {
        if let error = error {
            throw error
        }
    }
    
    func getFavoritedImages() -> [BreedImage] {
        breedImages.filter { $0.isFavorite }
    }
}
