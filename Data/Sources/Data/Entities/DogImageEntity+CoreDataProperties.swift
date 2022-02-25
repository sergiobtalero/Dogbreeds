//
//  DogImageEntity+CoreDataProperties.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 25/02/22.
//
//

import Foundation
import CoreData


extension DogImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogImageEntity> {
        return NSFetchRequest<DogImageEntity>(entityName: "DogImageEntity")
    }

    @NSManaged public var urlString: String?
    @NSManaged public var favorited: Bool
    @NSManaged public var breed: DogBreedEntity?

}

extension DogImageEntity : Identifiable {

}
