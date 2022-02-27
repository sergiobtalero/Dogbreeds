//
//  DogBreedsPersistedProvider.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation
import CoreData
import Domain

public final class DogBreedsPersistedProvider {
    private let coreDataManager: CoreDataManager
    
    // MARK: - Initializer
    public init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

// MARK: - DogBreedsPersistedProviderContract
extension DogBreedsPersistedProvider: DogBreedsPersistedProviderContract {
    public func fetchDogFamilies() -> [DogFamily] {
        let fetchRequest = DogFamiliyEntity.fetchRequest()
        do {
            let entities = try coreDataManager.viewContext.fetch(fetchRequest)
            return entities.map { DogFamilyMapper.map(input: $0) }
        } catch {
            return []
        }
    }
    
    public func fetchDogfamiliy(name: String) throws -> DogFamily {
        let fetchRequest = DogFamiliyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DogBreedEntity.name), name)
        
        if let entity = try? coreDataManager.viewContext.fetch(fetchRequest).first {
            return DogFamilyMapper.map(input: entity)
        } else {
            throw DogBreedsPersistedProviderError.notFound
        }
    }
    
    public func fetchDogBreedsCount() -> Int {
        let fetchRequest = DogBreedEntity.fetchRequest()
        do {
            let entitiesCount = try coreDataManager.viewContext.count(for: fetchRequest)
            return entitiesCount
        } catch {
            return .zero
        }
    }
    
    public func storeDogBreeds(from dictionary: [String: [String]]) {
        dictionary.forEach { element in
            let dogBreedsArray = element.value.map { dogBreedName -> DogBreedEntity in
                let newDogBreedEntity = DogBreedEntity(context: coreDataManager.viewContext)
                newDogBreedEntity.name = dogBreedName
                newDogBreedEntity.images = NSSet(array: [])
                return newDogBreedEntity
            }
            
            let newDogFamily = DogFamiliyEntity(context: coreDataManager.viewContext)
            newDogFamily.name = element.key
            newDogFamily.breeds = NSSet(array: dogBreedsArray)
        }
        
        try? coreDataManager.viewContext.save()
    }
    
    public func updateDogBreed(_ dogBreed: String,
                               images: [String]) throws {
        let fetchRequest = DogBreedEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DogBreedEntity.name), dogBreed)
        
        guard let result = try? coreDataManager.viewContext.fetch(fetchRequest).first else {
            throw DogBreedsPersistedProviderError.notFound
        }
        
        let imagesEntities = images.map { image -> DogImageEntity in
            let imageEntity = DogImageEntity(context: coreDataManager.viewContext)
            imageEntity.urlString = image
            imageEntity.breed = result
            imageEntity.favorited = false
            return imageEntity
        }
        
        result.setValue(NSSet(array: imagesEntities), forKey: "images")
        
        try? coreDataManager.viewContext.save()
    }
    
    public func toggleDogBreedImageFavoriteStatus(_ image: String) throws {
        let fetchRequest = DogImageEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DogImageEntity.urlString), image)
        
        guard let result = try? coreDataManager.viewContext.fetch(fetchRequest).first else {
            throw DogBreedsPersistedProviderError.notFound
        }
        
        result.setValue(!result.favorited, forKey: "favorited")
        
        try? coreDataManager.viewContext.save()
    }
}
