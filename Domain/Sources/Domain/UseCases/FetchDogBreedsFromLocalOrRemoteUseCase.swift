//
//  FetchDogBreedsFromLocalOrRemoteUseCase.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

public protocol FetchDogBreedsFromLocalOrRemoteUseCaseContract {
    func execute() async throws -> [DogBreed]
}

public enum FetchDogBreedsFromLocalOrRemoteUseCaseError: Error {
    case networkError
    case saveFailed
}

public final class FetchDogBreedsFromLocalOrRemoteUseCase {
    private let getPersistedDogBreedsCountUseCase: GetPersistedDogBreedsCountUseCaseContract
    private let fetchDogBreedsFromServiceUseCase: FetchDogBreedsDictionaryFromServiceUseCaseContract
    private let getPersistedDogBreedsUseCase: GetPersistedDogBreedsUseCaseContract
    private let storeDogBreedsUseCase: StoreDogBreedsUseCaseContract
    
    // MARK: - Initializer
    public init(getPersistedDogBreedsCountUseCase: GetPersistedDogBreedsCountUseCaseContract,
                fetchDogBreedsFromServiceUseCase: FetchDogBreedsDictionaryFromServiceUseCaseContract,
                getPersistedDogBreedsUseCase: GetPersistedDogBreedsUseCaseContract,
                storeDogBreedsUseCase: StoreDogBreedsUseCaseContract) {
        self.getPersistedDogBreedsCountUseCase = getPersistedDogBreedsCountUseCase
        self.fetchDogBreedsFromServiceUseCase = fetchDogBreedsFromServiceUseCase
        self.getPersistedDogBreedsUseCase = getPersistedDogBreedsUseCase
        self.storeDogBreedsUseCase = storeDogBreedsUseCase
    }
}

// MARK: - FetchDogBreedsFromLocalOrRemoteUseCaseContract
extension FetchDogBreedsFromLocalOrRemoteUseCase: FetchDogBreedsFromLocalOrRemoteUseCaseContract {
    public func execute() async throws -> [DogBreed] {
        let dogBreedsCount = getPersistedDogBreedsCountUseCase.execute()
        
        if dogBreedsCount == .zero {
            do {
                let dogBreedsDictionary = try await  fetchDogBreedsFromServiceUseCase.execute()
                try storeDogBreedsUseCase.execute(dictionary: dogBreedsDictionary)
            } catch FetchDogBreedsDictionaryFromServiceUseCaseError.networkError {
                throw FetchDogBreedsFromLocalOrRemoteUseCaseError.networkError
            } catch {
                throw FetchDogBreedsFromLocalOrRemoteUseCaseError.saveFailed
            }
        }
        
        return getPersistedDogBreedsUseCase.execute()
    }
}
