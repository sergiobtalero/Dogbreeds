//
//  DogBreed.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public struct DogBreed: Identifiable, Equatable {
    public let id: UUID
    public let name: String
    public let images: [BreedImage]
    
    // MARK: - Initializer
    public init(name: String,
                images: [BreedImage]) {
        id = UUID()
        
        self.name = name
        self.images = images
    }
}
