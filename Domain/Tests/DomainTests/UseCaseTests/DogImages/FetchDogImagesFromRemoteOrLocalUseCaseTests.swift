//
//  FetchDogImagesFromRemoteOrLocalUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class FetchDogImagesFromRemoteOrLocalUseCaseTests: XCTestCase {
    func testExample() async throws {
        let images = BreedImage.testBreedImages
        let imagesURLs = images.map { $0.url.absoluteString }
        let networkProvider = MockDogBreedNetworkProvider(error: nil,
                                                           dictionary: ["Mountain": ["Bernaise", "Alaska"]],
                                                           images: imagesURLs)
        let persistedProvider = MockDogBreedsPersistedProvider(error: nil,
                                                               dogFamilies: DogFamily.testDogFamilies,
                                                               breedImages: images)
        
        let getDogImagesFromServiceUseCase = GetDogImagesFromServiceUseCase(breedsNetworkProvider: networkProvider)
        let getPersistedDogBreedImagesCountUseCase = GetPersistedDogBreedImagesCountUseCase(dogBreedsPersistedProvider: persistedProvider)
        let getPersistedDogBreedImagesUseCase = GetPersistedDogBreedImagesUseCase(dogBreedsPersistedProvider: persistedProvider)
        let updateDogBreedWithImagesUseCase = UpdateDogBreedWithImagesUseCase(dogBreedsPersistedProvider: persistedProvider)
        
        let sut = FetchDogImagesFromRemoteOrLocalUseCase(getDogImagesFromServiceUseCase: getDogImagesFromServiceUseCase,
                                                         getPersistedDogBreedImagesCountUseCase: getPersistedDogBreedImagesCountUseCase,
                                                         getPersistedDogBreedImagesUseCase: getPersistedDogBreedImagesUseCase,
                                                         updateDogBreedWithImagesUseCase: updateDogBreedWithImagesUseCase)
        
        let response = try await sut.execute(dogBreedName: "Bernaise", familyName: "Moutain")
        XCTAssertEqual(response.count, 4)
    }
}
