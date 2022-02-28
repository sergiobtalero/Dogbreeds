//
//  MockFetchDogImagesFromRemoteOrLocalUseCase.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

import Foundation
import Domain

class MockFetchDogImagesFromRemoteOrLocalUseCase: FetchDogImagesFromRemoteOrLocalUseCaseContract {
    let error: Error?
    let images: [BreedImage]
    
    // MARK:- Initializer
    init(error: Error?,
         images: [BreedImage]) {
        self.error = error
        self.images = images
    }
    
    func execute(dogBreedName: String,
                 familyName: String?) async throws -> [BreedImage] {
        if let error = error {
            throw error
        }
        
        return images
    }
}
