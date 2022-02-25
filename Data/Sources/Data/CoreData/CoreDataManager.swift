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
    
    private static let modelName = "DogBreeds"
    private let persistentContainer: NSPersistentContainer
    
    public var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        persistentContainer.newBackgroundContext()
    }()
    
    // MARK: - Initializer
    init() {
        guard let url = Bundle.module.url(forResource: Self.modelName, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
                  fatalError("Could not load managed object store")
              }
        
        persistentContainer = NSPersistentContainer(name: Self.modelName,
                                                    managedObjectModel: managedObjectModel)
        
        persistentContainer.loadPersistentStores { [unowned self] _, error in
            if let error = error {
                fatalError("Failed loading persistent container with Error: \(error.localizedDescription)")
            }
            
            self.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        }
    }
}
