//
//  GetPersistedDogFamiliesUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class GetPersistedDogFamiliesUseCaseTests: XCTestCase {
    func testExecution_successful() throws {
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: DogFamily.testDogFamilies, breedImages: [])
        let sut = GetPersistedDogFamiliesUseCase(dogBreedsPersistedProvider: provider)
        let response = sut.execute()
        XCTAssertEqual(response.count, 2)
    }
    
    func testExecution_failure() throws {
        let provider = MockDogBreedsPersistedProvider(error: TestError.general, dogFamilies: [], breedImages: [])
        let sut = GetPersistedDogFamiliesUseCase(dogBreedsPersistedProvider: provider)
        let response = sut.execute()
        XCTAssertEqual(response.count, 0)
    }
}
