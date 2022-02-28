//
//  StoreDogFamiliesUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class StoreDogFamiliesUseCaseTests: XCTestCase {
    func testExecution_successful() throws {
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: [], breedImages: [])
        let dictionary = ["Mountain": ["Alaska", "Bernaise"], "German Shepperd": []]
        let sut = StoreDogFamiliesUseCase(provider: provider)
        try sut.execute(dictionary: dictionary)
    }
    
    func testExecution_failure() throws {
        let provider = MockDogBreedsPersistedProvider(error: TestError.general, dogFamilies: [], breedImages: [])
        let dictionary = ["Mountain": ["Alaska", "Bernaise"], "German Shepperd": []]
        let sut = StoreDogFamiliesUseCase(provider: provider)
        try sut.execute(dictionary: dictionary)
    }
}
