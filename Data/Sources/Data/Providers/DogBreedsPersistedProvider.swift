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
    public func fetchDogBreeds() -> [DogBreed] {
        let fetchRequest = DogBreedEntity.fetchRequest()
        do {
            let entities = try coreDataManager.viewContext.fetch(fetchRequest)
            return entities.map { DogBreedMapper.map(input: $0) }
        } catch {
            return []
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
    
    public func storeDogBreeds(from dictionary: [String: [String]]) throws {
        for breed in dictionary {
            if breed.value.isEmpty {
                let newEntity = DogBreedEntity(context: coreDataManager.viewContext)
                newEntity.name = breed.key
                newEntity.breedFamiliy = nil
                continue
            }
            
            breed.value.forEach { subBreed in
                let newEntity = DogBreedEntity(context: coreDataManager.viewContext)
                newEntity.name = subBreed
                newEntity.breedFamiliy = breed.key
            }
        }
        
        do {
            try coreDataManager.viewContext.save()
        } catch {
            coreDataManager.viewContext.rollback()
            throw error
        }
    }
}
