//
//  GetDogImagesUseCaseContract.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

public protocol GetDogImagesFromServiceUseCaseContract {
    func execute(breedName: String) async throws -> [String]
}

public final class GetDogImagesFromServiceUseCase {
    private let breedsNetworkProvider: DogBreedsNetworkProviderContract
    
    // MARK: - Initializer
    public init(breedsNetworkProvider: DogBreedsNetworkProviderContract) {
        self.breedsNetworkProvider = breedsNetworkProvider
    }
}

// MARK: - GetDogImagesFromServiceUseCaseContract
extension GetDogImagesFromServiceUseCase: GetDogImagesFromServiceUseCaseContract {
    public func execute(breedName: String) async throws -> [String] {
        return try await breedsNetworkProvider.fetchImages(forBreed: breedName)
    }
}
