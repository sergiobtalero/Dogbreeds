//
//  CoreDataManager.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation
import CoreData

public class CoreDataManager {
    public static var shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    public var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        persistentContainer.newBackgroundContext()
    }()
    
    // MARK: - Initializer
    init(persistentContainer: NSPersistentContainer = mainContainer) {
        self.persistentContainer = persistentContainer
    }
}

// MARK: - Private extension
extension CoreDataManager {
    static let mainContainer: NSPersistentContainer = {
        let modelName = "DogBreeds"
        guard let url = Bundle.module.url(forResource: modelName, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
                  fatalError("Could not load managed object store")
              }
        
        let container = NSPersistentContainer(name: modelName,
                                                    managedObjectModel: managedObjectModel)
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed loading persistent container with Error: \(error.localizedDescription)")
            }
            
            container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        }
        return container
    }()
}
