//
//  DogFamilyMapper.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation
import Domain

class DogFamilyMapper: Mapper {
    static func map(input: DogFamiliyEntity) ->DogFamily {
        var breeds: [DogBreed] = []
        
        if let inputBreeds = input.breeds {
            breeds = Array(inputBreeds).compactMap {
                if let breedEntity = $0 as? DogBreedEntity {
                    return DogBreedMapper.map(input: breedEntity)
                } else {
                    return nil
                }
            }
        }
        
        return DogFamily(name: input.name ?? "",
                         breeds: breeds)
    }
}
