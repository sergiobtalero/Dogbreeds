//
//  BreedImageMapper.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation
import Domain

final class BreedImageMapper: Mapper {
    static func map(input: DogImageEntity) -> BreedImage? {
        guard let url = URL(string: input.urlString ?? "") else {
            return nil
        }
        
        return BreedImage(url: url, isFavorite: input.favorited)
    }
}
