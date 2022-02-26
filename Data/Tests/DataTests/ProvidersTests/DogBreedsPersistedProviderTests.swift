//
//  DogBreedsPersistedProviderTests.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

@testable import Data
import CoreData
import XCTest

class DogBreedsPersistedProviderTests: XCTestCase {
    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        let modelName = "DogBreeds"
        
        guard let url = CoreDataManager.momURL,
              let managedObjectModel = NSManagedObjectModel(contentsOf: url)else {
                  fatalError("Could not load managed object model")
              }
        
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        coreDataManager = CoreDataManager(persistentContainer: container)
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
    }

    func testFetchDogBreedsCount_successfully() throws {
        guard let url = Bundle.module.url(forResource: "DogBreedsList", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let dictionary = try? JSONDecoder().decode(DogServiceResponse<[String: [String]]>.self, from: data) else {
                  XCTFail("Could not load data from DogBreedsList.json")
                  return
              }
        let dogBreedsDictionary = dictionary.message
        let sut = DogBreedsPersistedProvider(coreDataManager: coreDataManager)
        
        sut.storeDogBreeds(from: dogBreedsDictionary)
        let count = sut.fetchDogBreedsCount()
        let dogBreeds = sut.fetchDogBreeds()
        XCTAssertEqual(count, dogBreeds.count)
    }

    func testUpdateDogBreedsImages_successfully() throws {
        guard let url = Bundle.module.url(forResource: "DogBreedsList", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let dictionary = try? JSONDecoder().decode(DogServiceResponse<[String: [String]]>.self, from: data) else {
                  XCTFail("Could not load data from DogBreedsList.json")
                  return
              }
        let dogBreedsDictionary = dictionary.message
        let sut = DogBreedsPersistedProvider(coreDataManager: coreDataManager)
        
        sut.storeDogBreeds(from: dogBreedsDictionary)
        guard let testDogBreed = sut.fetchDogBreeds().first else {
            XCTFail("Failed to load dog breeds")
            return
        }
        
        try sut.updateDogBreed(testDogBreed.name, images: ["http://www.test.com",
                                                           "http://www.test2.com",
                                                           "http://www.test3.com"])
        let images = try sut.fetchDogBreed(name: testDogBreed.name).images.sorted(by: { $0.url.absoluteString < $1.url.absoluteString })
        XCTAssertEqual(images.count, 3)
        XCTAssertEqual(images[0].url.absoluteString, "http://www.test.com")
        XCTAssertEqual(images[1].url.absoluteString, "http://www.test2.com")
        XCTAssertEqual(images[2].url.absoluteString, "http://www.test3.com")
    }
    
    func testToggleDogBreedsImageFavoriteStatus_successfully() throws {
        guard let url = Bundle.module.url(forResource: "DogBreedsList", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let dictionary = try? JSONDecoder().decode(DogServiceResponse<[String: [String]]>.self, from: data) else {
                  XCTFail("Could not load data from DogBreedsList.json")
                  return
              }
        let dogBreedsDictionary = dictionary.message
        let sut = DogBreedsPersistedProvider(coreDataManager: coreDataManager)
        
        sut.storeDogBreeds(from: dogBreedsDictionary)
        guard let testDogBreed = sut.fetchDogBreeds().first else {
            XCTFail("Failed to load dog breeds")
            return
        }
        
        try sut.updateDogBreed(testDogBreed.name, images: ["http://www.test.com",
                                                           "http://www.test2.com",
                                                           "http://www.test3.com"])
        try sut.toggleDogBreedImageFavoriteStatus("http://www.test.com")
        if let image = try sut.fetchDogBreed(name: testDogBreed.name).images.first(where: { $0.url.absoluteString == "http://www.test.com" }) {
            XCTAssertTrue(image.isFavorite)
        } else {
            XCTFail("Could not find image")
        }
    }
}
