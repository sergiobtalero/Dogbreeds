//
//  GetDogBreedsUseCase.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public protocol FetchDogFamiliesDictionaryFromServiceUseCaseContract {
    func execute() async throws -> [String: [String]]
}

enum FetchDogFamiliesDictionaryFromServiceUseCaseError: Error {
    case networkError
}

public final class FetchDogFamiliesDictionaryFromServiceUseCase {
    private let breedsNetworkProvider: DogBreedsNetworkProviderContract
    
    // MARK: - Initializer
    public init(breedsNetworkProvider: DogBreedsNetworkProviderContract) {
        self.breedsNetworkProvider = breedsNetworkProvider
    }
}

// MARK: - GetDogBreedUseCaseContract
extension FetchDogFamiliesDictionaryFromServiceUseCase: FetchDogFamiliesDictionaryFromServiceUseCaseContract {
    public func execute() async throws -> [String: [String]] {
        do {
            let dictionary = try await breedsNetworkProvider.fetchAllBreedsList()
            return dictionary
        } catch {
            throw FetchDogFamiliesDictionaryFromServiceUseCaseError.networkError
        }
    }
}
