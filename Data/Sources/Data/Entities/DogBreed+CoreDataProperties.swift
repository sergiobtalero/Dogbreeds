//
//  DogBreed+CoreDataProperties.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 25/02/22.
//
//

import Foundation
import CoreData


extension DogBreedEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogBreedEntity> {
        return NSFetchRequest<DogBreedEntity>(entityName: "DogBreedEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var subBreeds: [String]?
    @NSManaged public var images: NSSet?

}

// MARK: Generated accessors for images
extension DogBreedEntity {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: DogImageEntity)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: DogImageEntity)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension DogBreedEntity : Identifiable {

}
