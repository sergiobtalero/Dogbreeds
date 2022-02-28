//
//  GetPersistedDogFamiliesCountUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class GetPersistedDogFamiliesCountUseCaseTests: XCTestCase {
    func testExecution_successful() throws {
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: DogFamily.testDogFamilies, breedImages: [])
        let sut = GetPersistedDogFamiliesCountUseCase(dogBreedsPersistedProvider: provider)
        
        let dogCount = sut.execute()
        XCTAssertEqual(dogCount, 2)
    }
    
    func testExecution_failure() throws {
        let provider = MockDogBreedsPersistedProvider(error: TestError.general, dogFamilies: [], breedImages: [])
        let sut = GetPersistedDogFamiliesCountUseCase(dogBreedsPersistedProvider: provider)
        
        let dogCount = sut.execute()
        XCTAssertEqual(dogCount, 0)
    }
}
