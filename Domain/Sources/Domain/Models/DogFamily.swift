//
//  DogFamily.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

public struct DogFamily: Identifiable, Equatable {
    public let id: UUID
    public let name: String
    public let breeds: [DogBreed]
    
    // MARK: - Initializer
    public init(name: String,
                breeds: [DogBreed]) {
        id = UUID()
        self.name = name
        self.breeds = breeds
    }
}
