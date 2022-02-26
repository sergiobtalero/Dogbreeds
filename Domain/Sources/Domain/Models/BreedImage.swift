//
//  BreedImage.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public struct BreedImage {
    public let url: URL
    public var isFavorite: Bool
    
    // MARK: - Initializer
    public init(url: URL,
                isFavorite: Bool) {
        self.url = url
        self.isFavorite = isFavorite
    }
}
