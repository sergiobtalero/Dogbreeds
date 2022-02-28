//
//  UpdateDogBreedWithImagesUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class UpdateDogBreedWithImagesUseCaseTests: XCTestCase {
    func testExample() throws {
        let images = BreedImage.testBreedImages
        let provider = MockDogBreedsPersistedProvider(error: nil, dogFamilies: DogFamily.testDogFamilies, breedImages: images)
        let sut = UpdateDogBreedWithImagesUseCase(dogBreedsPersistedProvider: provider)
        let imagesURLs = images.map { $0.url.absoluteString }
        sut.execute(dogBreedName: "Bernaise", images: imagesURLs)
    }
}
