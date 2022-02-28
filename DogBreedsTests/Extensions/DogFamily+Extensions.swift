//
//  DogFamily+Extensions.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

import Foundation
import Domain

extension DogFamily {
    static var testingData: [DogFamily] {
        [
            DogFamily(name: "Mountain", breeds: [
                DogBreed(name: "Bernaise",
                         familyName: "Mountain",
                         images: [
                            BreedImage(url: URL(string: "http://www.test.com")!, isFavorite: true),
                            BreedImage(url: URL(string: "http://www.test2.com")!, isFavorite: true),
                            BreedImage(url: URL(string: "http://www.test3.com")!, isFavorite: true),
                            BreedImage(url: URL(string: "http://www.test4.com")!, isFavorite: true),
                         ])
                ]),
            DogFamily(name: "German Shepperd", breeds: []),
            DogFamily(name: "Cocker Spaniel", breeds: [])
        ]
    }
}
