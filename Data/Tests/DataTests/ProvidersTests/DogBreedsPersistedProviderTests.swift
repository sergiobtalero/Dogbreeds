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
        XCTAssertEqual(count, 79)
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
        let images = ["http://www.test.com",
                      "http://www.test2.com",
                      "http://www.test3.com"]
        let testDog = sut.fetchDogFamilies().first(where: { !$0.breeds.isEmpty })!.breeds.first!
        print(testDog)
        try sut.addImages(images, dogBreedName: testDog.name)
        let dogImages = sut.getImagesOfBreed(testDog.name)
        XCTAssertEqual(dogImages.count, 3)
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
        guard let testDogBreed = sut.fetchDogFamilies().first else {
            XCTFail("Failed to load dog breeds")
            return
        }
        let images = ["http://www.test.com",
                      "http://www.test2.com",
                      "http://www.test3.com"]
        let testDog = sut.fetchDogFamilies().first(where: { $0.breeds.isEmpty })!
        try sut.addImages(images, dogFamilyName: testDog.name)
        try sut.toggleDogBreedImageFavoriteStatus("http://www.test.com")
        
        let dogImagesimages = try sut.getFavoritedImages()
        XCTAssertTrue(dogImagesimages.contains(where: { $0.url.absoluteString == "http://www.test.com" }))
    }
}
