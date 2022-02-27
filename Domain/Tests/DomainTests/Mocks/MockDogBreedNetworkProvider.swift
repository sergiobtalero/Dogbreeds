//
//  MockDogBreedNetworkProvider.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import Foundation


class MockDogBreedNetworkProvider: DogBreedsNetworkProviderContract {
    let error: Error?
    let dictionary: [String: [String]]
    let images: [String]
    
    // MARK: - Initializer
    init(error: Error?, dictionary: [String: [String]], images: [String]) {
        self.error = error
        self.dictionary = dictionary
        self.images = images
    }
    
    func fetchAllBreedsList() async throws -> [String : [String]] {
        if let error = error {
            throw error
        }
        
        return dictionary
    }
    
    func fetchImages(forBreed breed: String) async throws -> [String] {
        if let error = error {
            throw error
        }
        
        return images
    }
}
