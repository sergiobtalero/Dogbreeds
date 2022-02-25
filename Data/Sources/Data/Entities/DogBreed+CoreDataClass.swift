//
//  DogBreed+CoreDataClass.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 25/02/22.
//
//

import Foundation
import CoreData

@objc(DogBreedEntity)
public class DogBreedEntity: NSManagedObject {
    public static func createNew(name: String,
                                 subBreeds: [String]?,
                                 images: Set<DogImageEntity>?) {
        let newEntity = DogBreedEntity(context: CoreDataManager.shared.viewContext)
        newEntity.name = name
        newEntity.subBreeds = subBreeds
        newEntity.images = images
    }
}
