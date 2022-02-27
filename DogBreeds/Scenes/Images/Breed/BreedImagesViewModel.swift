//
//  BreedImagesViewModel.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

@MainActor final class BreedImagesViewModel: ObservableObject {
    private let breedName: String
    
    // MARK: - Initializer
    init(breedName: String) {
        self.breedName = breedName
    }
}
