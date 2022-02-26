//
//  DogBreed.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public struct DogBreed {
    public let name: String
    public let breedFamily: String
    public let images: [BreedImage]
    
    // MARK: - Initializer
    public init(name: String,
                breedFamily: String,
                images: [BreedImage]) {
        self.name = name
        self.breedFamily = breedFamily
        self.images = images
    }
}
