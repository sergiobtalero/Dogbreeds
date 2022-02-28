//
//  BreedImage+Extensions.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

import Foundation
import Domain

extension BreedImage {
    static var testingData: [BreedImage] {
        [
            BreedImage(url: URL(string: "http://www.test.com")!, isFavorite: true),
            BreedImage(url: URL(string: "http://www.test2.com")!, isFavorite: true),
            BreedImage(url: URL(string: "http://www.test3.com")!, isFavorite: false),
            BreedImage(url: URL(string: "http://www.test4.com")!, isFavorite: false),
            BreedImage(url: URL(string: "http://www.test5.com")!, isFavorite: false)
        ]
    }
}
