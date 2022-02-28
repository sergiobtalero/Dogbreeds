//
//  File.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation
import Domain

extension DogFamily {
    static var testDogFamilies: [DogFamily] {
        [
            DogFamily(name: "Mountain", breeds: [DogBreed(name: "Bernaise", familyName: "Mountain", images: [])]),
            DogFamily(name: "Cocker Spaniel", breeds: [])
        ]
    }
}
