//
//  ToggleLikeStatusOfDogImageUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class ToggleLikeStatusOfDogImageUseCaseTests: XCTestCase {
    func testExecution_successful() throws {
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: DogFamily.testDogFamilies, breedImages: BreedImage.testBreedImages)
        let sut = ToggleLikeStatusOfDogImageUseCase(dogBreedsPersistedProvider: provider)
        let testImage = BreedImage.testBreedImages.first!
        try sut.execute(breedImage: testImage)
    }
    
    func testExecution_failure() throws {
        let provider = MockDogBreedsPersistedProvider(error: TestError.general, dogFamilies: DogFamily.testDogFamilies, breedImages: BreedImage.testBreedImages)
        let sut = ToggleLikeStatusOfDogImageUseCase(dogBreedsPersistedProvider: provider)
        let testImage = BreedImage.testBreedImages.first!
        do {
            try sut.execute(breedImage: testImage)
            XCTFail("Unexpected response")
        } catch {
            XCTAssertEqual(error as? TestError, .general)
        }
    }
}
