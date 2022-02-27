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
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(SubBreedEntity.name), name)
        
        if let entity = try? coreDataManager.viewContext.fetch(fetchRequest).first {
            return DogFamilyMapper.map(input: entity)
        } else {
            throw DogBreedsPersistedProviderError.notFound
        }
    }
    
    public func fetchDogBreedsCount() -> Int {
        let fetchRequest = SubBreedEntity.fetchRequest()
        do {
            let entitiesCount = try coreDataManager.viewContext.count(for: fetchRequest)
            return entitiesCount
        } catch {
            return .zero
        }
    }
    
    public func storeDogBreeds(from dictionary: [String: [String]]) {
        dictionary.forEach { element in
            let dogBreedsArray = element.value.map { dogBreedName -> SubBreedEntity in
                let newDogBreedEntity = SubBreedEntity(context: coreDataManager.viewContext)
                newDogBreedEntity.name = dogBreedName
                newDogBreedEntity.images = NSSet(array: [])
                return newDogBreedEntity
            }
            
            let newDogFamily = DogFamiliyEntity(context: coreDataManager.viewContext)
            newDogFamily.name = element.key
            newDogFamily.breeds = NSSet(array: dogBreedsArray)
            newDogFamily.images = NSSet(array: [])
        }
        
        try? coreDataManager.viewContext.save()
    }
    
    public func getImagesOfBreed(_ dogBreed: String) -> [BreedImage] {
        let dogBreedFetchRequest = SubBreedEntity.fetchRequest()
        dogBreedFetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(SubBreedEntity.name), dogBreed)
        
        if let dogBreed = try? coreDataManager.viewContext.fetch(dogBreedFetchRequest).first,
           let images = dogBreed.images?.allObjects as? [DogImageEntity], !images.isEmpty {
            return images.compactMap { BreedImageMapper.map(input: $0) }
        }
        
        let dogFamiliyFetchRequest = DogFamiliyEntity.fetchRequest()
        dogFamiliyFetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DogFamiliyEntity.name), dogBreed)
        
        if let dogFamily = try? coreDataManager.viewContext.fetch(dogFamiliyFetchRequest).first,
           let images = dogFamily.images?.allObjects as? [DogImageEntity], !images.isEmpty {
            return images.compactMap { BreedImageMapper.map(input: $0) }
        }
        
        return []
    }
    
    public func getImagesCountOfBreed(_ dogBreed: String) -> Int {
        let dogBreedFetchRequest = SubBreedEntity.fetchRequest()
        dogBreedFetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(SubBreedEntity.name), dogBreed)
        
        if let dogBreed = try? coreDataManager.viewContext.fetch(dogBreedFetchRequest).first,
           let images = dogBreed.images?.allObjects as? [DogImageEntity], !images.isEmpty {
            return images.count
        }
        
        let dogFamiliyFetchRequest = DogFamiliyEntity.fetchRequest()
        dogFamiliyFetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DogFamiliyEntity.name), dogBreed)
        
        if let dogFamily = try? coreDataManager.viewContext.fetch(dogFamiliyFetchRequest).first,
           let images = dogFamily.images?.allObjects as? [DogImageEntity], !images.isEmpty {
            return images.count
        }
        
        return .zero
    }
    
    public func addImages(_ images: [String], dogBreedName: String) throws {
        let fetchRequest = SubBreedEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(SubBreedEntity.name), dogBreedName)
        
        guard let result = try? coreDataManager.viewContext.fetch(fetchRequest).first else {
            throw DogBreedsPersistedProviderError.notFound
        }
        
        let imagesEntities = images.map { image -> DogImageEntity in
            let imageEntity = DogImageEntity(context: coreDataManager.viewContext)
            imageEntity.urlString = image
            imageEntity.breed = result
            imageEntity.dogFamily = nil
            imageEntity.favorited = false
            return imageEntity
        }
        result.setValue(NSSet(array: imagesEntities), forKey: "images")
        try? coreDataManager.viewContext.save()
    }
    
    public func addImages(_ images: [String], dogFamilyName: String) throws {
        let fetchRequest = DogFamiliyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DogFamiliyEntity.name), dogFamilyName)
        
        guard let result = try? coreDataManager.viewContext.fetch(fetchRequest).first else {
            throw DogBreedsPersistedProviderError.notFound
        }
        
        let imagesEntities = images.map { image -> DogImageEntity in
            let imageEntity = DogImageEntity(context: coreDataManager.viewContext)
            imageEntity.urlString = image
            imageEntity.dogFamily = result
            imageEntity.breed = nil
            imageEntity.favorited = false
            return imageEntity
        }
        result.setValue(NSSet(array: imagesEntities), forKey: "images")
        
        do {
            try coreDataManager.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
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
