//
//  DogBreedsProvider.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation
import Domain

public final class DogBreedsNetworkProvider {
    private let breedsService: BreedsServiceContract
    
    // MARK: - Initializer
    public init(breedsService: BreedsServiceContract) {
        self.breedsService = breedsService
    }
}

// MARK: - DogBreedsProviderContract
extension DogBreedsNetworkProvider: DogBreedsNetworkProviderContract {    
    public func fetchAllBreedsList() async throws -> [String: [String]] {
        do {
            let breedsDictionary: DogServiceResponse<[String: [String]]> = try await breedsService.request(endpoint: BreedsEndpoint.list)
            return breedsDictionary.message
        } catch {
            throw DogBreedsNetworkProviderError.general
        }
    }
    
    public func fetchImages(forBreed breed: String) async throws -> [String] {
        do {
            let images: DogServiceResponse<[String]> = try await breedsService.request(endpoint: BreedEndpoint.images(breed))
            return images.message
        } catch {
            throw DogBreedsNetworkProviderError.general
        }
    }
}
