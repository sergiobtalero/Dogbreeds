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
    public func fetchAllBreedsList() async {
        let _ = CoreDataManager.shared
        do {
            let breedsDictionary: DogServiceResponse<[String: [String]]> = try await breedsService.request(endpoint: BreedsEndpoint.list)
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    public func fetchImages(forBreed breed: String) async {
        fatalError("Not implemented")
    }
    
    public func fetchSubBreeds(of breed: String) async {
        fatalError("Not implemented")
    }
}
