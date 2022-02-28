//
//  MockFetchDogFamiliesFromLocalOrRemoteUseCase.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

import Foundation
import Domain

class MockFetchDogFamiliesFromLocalOrRemoteUseCase: FetchDogFamiliesFromLocalOrRemoteUseCaseContract {
    let error: Error?
    let dogFamilies: [DogFamily]
    
    // MARK: - Initializer
    init(error: Error?, dogFamilies: [DogFamily]) {
        self.error = error
        self.dogFamilies = dogFamilies
    }
    
    // MARK: - Execute
    func execute() async throws -> [DogFamily] {
        if let error = error {
            throw error
        } else {
            return dogFamilies
        }
    }
}
