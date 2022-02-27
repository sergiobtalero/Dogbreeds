//
//  DogBreedMapper.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation
import Domain

final class DogBreedMapper: Mapper {
    static func map(input: SubBreedEntity) -> DogBreed {
        var images: [BreedImage] = []
        
        if let inputImages = input.images {
            images = Array(inputImages).compactMap {
                if let imageEntity = $0 as? DogImageEntity {
                    return BreedImageMapper.map(input: imageEntity)
                } else {
                    return nil
                }
            }
        }

        return DogBreed(name: input.name ?? "",
                        familyName: input.dogFamiliy?.name ?? "",
                        images: images)
    }
}
