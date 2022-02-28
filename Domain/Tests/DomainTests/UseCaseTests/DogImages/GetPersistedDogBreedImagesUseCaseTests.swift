//
//  GetPersistedDogBreedImagesUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class GetPersistedDogBreedImagesUseCaseTests: XCTestCase {
    func testExample() throws {
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: DogFamily.testDogFamilies, breedImages: BreedImage.testBreedImages)
        let sut = GetPersistedDogBreedImagesUseCase(dogBreedsPersistedProvider: provider)
        let response = sut.execute(dogBreedName: "Bernaise")
        XCTAssertEqual(response.count, 4)
    }
}
