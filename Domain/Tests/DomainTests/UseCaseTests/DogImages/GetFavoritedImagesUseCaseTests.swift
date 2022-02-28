//
//  GetFavoritedImagesUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class GetFavoritedImagesUseCaseTests: XCTestCase {
    func testExecution_succes() throws {
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: [], breedImages: BreedImage.testBreedImages)
        let sut = GetFavoritedImagesUseCase(dogBreedsPersistedProvider: provider)
        let response = sut.execute()
        XCTAssertEqual(response.count, 2)
    }
    
    func testExecution_failure() throws {
        let provider = MockDogBreedsPersistedProvider(error: TestError.general, dogFamilies: [], breedImages: [])
        let sut = GetFavoritedImagesUseCase(dogBreedsPersistedProvider: provider)
        let response = sut.execute()
        XCTAssertEqual(response.count, 0)
    }
}
