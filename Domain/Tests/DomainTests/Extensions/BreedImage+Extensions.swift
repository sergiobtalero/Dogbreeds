//
//  File.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation
import Domain

extension BreedImage {
    static var testBreedImages: [BreedImage] {
        [
            BreedImage(url: URL(string: "http://www.test.com")!, isFavorite: true),
            BreedImage(url: URL(string: "http://www.test2.com")!, isFavorite: false),
            BreedImage(url: URL(string: "http://www.test3.com")!, isFavorite: true),
            BreedImage(url: URL(string: "http://www.test4.com")!, isFavorite: false)
        ]
    }
}
