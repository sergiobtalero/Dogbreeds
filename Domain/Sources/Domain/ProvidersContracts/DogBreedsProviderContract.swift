//
//  DogBreedsProviderContract.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public enum DogBreedsNetworkProviderError: Error {
    case general
}

public protocol DogBreedsNetworkProviderContract {
    func fetchAllBreedsList() async throws -> [String: [String]]
    func fetchImages(forBreed breed: String) async throws -> [String]
}
