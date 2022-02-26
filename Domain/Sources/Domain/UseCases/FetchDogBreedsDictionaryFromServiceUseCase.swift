//
//  GetDogBreedsUseCase.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public protocol FetchDogBreedsDictionaryFromServiceUseCaseContract {
    func execute() async throws -> [String: [String]]
}

enum FetchDogBreedsDictionaryFromServiceUseCaseError: Error {
    case networkError
}

public final class FetchDogBreedsDictionaryFromServiceUseCase {
    private let breedsNetworkProvider: DogBreedsNetworkProviderContract
    
    // MARK: - Initializer
    public init(breedsNetworkProvider: DogBreedsNetworkProviderContract) {
        self.breedsNetworkProvider = breedsNetworkProvider
    }
}

// MARK: - GetDogBreedUseCaseContract
extension FetchDogBreedsDictionaryFromServiceUseCase: FetchDogBreedsDictionaryFromServiceUseCaseContract {
    public func execute() async throws -> [String: [String]] {
        do {
            let dictionary = try await breedsNetworkProvider.fetchAllBreedsList()
            return dictionary
        } catch {
            throw FetchDogBreedsDictionaryFromServiceUseCaseError.networkError
        }
    }
}
