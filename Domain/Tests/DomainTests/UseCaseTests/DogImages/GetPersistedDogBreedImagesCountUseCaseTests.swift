//
//  GetPersistedDogBreedImagesCountUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class GetPersistedDogBreedImagesCountUseCaseTests: XCTestCase {
    func testExecution_successful() throws {
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: DogFamily.testDogFamilies, breedImages: BreedImage.testBreedImages)
        let sut = GetPersistedDogBreedImagesCountUseCase(dogBreedsPersistedProvider: provider)
        let response = sut.execute(dogBreedName: "Bernaise")
        XCTAssertEqual(response, 4)
    }
}
