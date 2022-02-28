//
//  FetchDogFamiliesFromLocalOrRemoteUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class FetchDogFamiliesFromLocalOrRemoteUseCaseTests: XCTestCase {
    func testFetchPersistedValues_success() async throws {
        let persistedProvider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: DogFamily.testDogFamilies, breedImages: [])
        let networkProvider = MockDogBreedNetworkProvider(error: nil, dictionary: [:], images: [])
        
        let getPersistedCountUseCase = GetPersistedDogFamiliesCountUseCase(dogBreedsPersistedProvider: persistedProvider)
        let fetchDogsFromNetworkUseCase = FetchDogFamiliesDictionaryFromServiceUseCase(breedsNetworkProvider: networkProvider)
        let getPersistedDogFamiliesUseCase = GetPersistedDogFamiliesUseCase(dogBreedsPersistedProvider: persistedProvider)
        let storeDogFamiliesUseCase = StoreDogFamiliesUseCase(provider: persistedProvider)
        
        let sut = FetchDogFamiliesFromLocalOrRemoteUseCase(getPersistedDogFamiliesCountUseCase: getPersistedCountUseCase,
                                                           fetchDogFamiliesFromServiceUseCase: fetchDogsFromNetworkUseCase,
                                                           getPersistedDogFamiliesUseCase: getPersistedDogFamiliesUseCase,
                                                           storeDogFamiliesUseCase: storeDogFamiliesUseCase)
        
        let response = try await sut.execute()
        XCTAssertEqual(response.count, 2)
    }
    
    func testFetchRemoteValues_success() async throws {
        let persistedProvider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: [], breedImages: [])
        let networkProvider = MockDogBreedNetworkProvider(error: nil, dictionary: ["Mountain": ["Bernaise", "Alaska"]], images: [])
        
        let getPersistedCountUseCase = GetPersistedDogFamiliesCountUseCase(dogBreedsPersistedProvider: persistedProvider)
        let fetchDogsFromNetworkUseCase = FetchDogFamiliesDictionaryFromServiceUseCase(breedsNetworkProvider: networkProvider)
        let getPersistedDogFamiliesUseCase = GetPersistedDogFamiliesUseCase(dogBreedsPersistedProvider: persistedProvider)
        let storeDogFamiliesUseCase = StoreDogFamiliesUseCase(provider: persistedProvider)
        
        let sut = FetchDogFamiliesFromLocalOrRemoteUseCase(getPersistedDogFamiliesCountUseCase: getPersistedCountUseCase,
                                                           fetchDogFamiliesFromServiceUseCase: fetchDogsFromNetworkUseCase,
                                                           getPersistedDogFamiliesUseCase: getPersistedDogFamiliesUseCase,
                                                           storeDogFamiliesUseCase: storeDogFamiliesUseCase)
        
        let response = try await sut.execute()
        XCTAssertEqual(response.count, 0)
    }
}
