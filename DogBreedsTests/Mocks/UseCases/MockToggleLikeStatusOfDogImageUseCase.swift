//
//  MockToggleLikeStatusOfDogImageUseCase.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

import Foundation
import Domain

class MockToggleLikeStatusOfDogImageUseCase: ToggleLikeStatusOfDogImageUseCaseContract {
    let error: Error?
    
    init(error: Error?) {
        self.error = error
    }
    
    
    func execute(breedImage: BreedImage) throws {
        if let error = error {
            throw error
        }
    }
}
