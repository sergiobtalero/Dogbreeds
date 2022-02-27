//
//  FetchDogBreedsFromLocalOrRemoteUseCase.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

public protocol FetchDogFamiliesFromLocalOrRemoteUseCaseContract {
    func execute() async throws -> [DogFamily]
}

public enum FetchDogFamiliesFromLocalOrRemoteUseCaseError: Error {
    case networkError
    case saveFailed
}

public final class FetchDogFamiliesFromLocalOrRemoteUseCase {
    private let getPersistedDogFamiliesCountUseCase: GetPersistedDogFamiliesCountUseCaseContract
    private let fetchDogFamiliesFromServiceUseCase: FetchDogFamiliesDictionaryFromServiceUseCaseContract
    private let getPersistedDogFamiliesUseCase: GetPersistedDogFamiliesUseCaseContract
    private let storeDogFamiliesUseCase: StoreDogFamiliesUseCaseContract
    
    // MARK: - Initializer
    public init(getPersistedDogFamiliesCountUseCase: GetPersistedDogFamiliesCountUseCaseContract,
                fetchDogFamiliesFromServiceUseCase: FetchDogFamiliesDictionaryFromServiceUseCaseContract,
                getPersistedDogFamiliesUseCase: GetPersistedDogFamiliesUseCaseContract,
                storeDogFamiliesUseCase: StoreDogFamiliesUseCaseContract) {
        self.getPersistedDogFamiliesCountUseCase = getPersistedDogFamiliesCountUseCase
        self.fetchDogFamiliesFromServiceUseCase = fetchDogFamiliesFromServiceUseCase
        self.getPersistedDogFamiliesUseCase = getPersistedDogFamiliesUseCase
        self.storeDogFamiliesUseCase = storeDogFamiliesUseCase
    }
}

// MARK: - FetchDogBreedsFromLocalOrRemoteUseCaseContract
extension FetchDogFamiliesFromLocalOrRemoteUseCase: FetchDogFamiliesFromLocalOrRemoteUseCaseContract {
    public func execute() async throws -> [DogFamily] {
        let dogBreedsCount = getPersistedDogFamiliesCountUseCase.execute()
        
        if dogBreedsCount == .zero {
            do {
                let dogBreedsDictionary = try await  fetchDogFamiliesFromServiceUseCase.execute()
                try storeDogFamiliesUseCase.execute(dictionary: dogBreedsDictionary)
            } catch FetchDogFamiliesDictionaryFromServiceUseCaseError.networkError {
                throw FetchDogFamiliesFromLocalOrRemoteUseCaseError.networkError
            } catch {
                throw FetchDogFamiliesFromLocalOrRemoteUseCaseError.saveFailed
            }
        }
        
        return getPersistedDogFamiliesUseCase.execute()
    }
}
