//
//  DogBreedsNetworkProviderTests.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

@testable import Data
import XCTest
import Domain

class DogBreedsNetworkProviderTests: XCTestCase {
    func testFetchAllBreedsList_successfully() async throws {
        // GIVEN
        guard let url = Bundle.module.url(forResource: "DogBreedsList", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
                  XCTFail("Could not load data from DogBreedsList.json")
                  return
              }
        let urlSession = MockURLSession(data: data, response: nil, error: nil)
        let service = BreedsService(urlSession: urlSession)
        let sut = DogBreedsNetworkProvider(breedsService: service)
        
        // WHEN
        do {
            let dictionary = try await sut.fetchAllBreedsList()
            XCTAssertEqual(dictionary.count, 95)
        } catch {
            XCTFail("Invalid error")
        }
    }
    
    func testFechAllBreedsList_requestFailed() async throws {
        // GIVEN
        let urlSession = MockURLSession(data: nil, response: nil, error: BreedsServiceError.requestFailed)
        let service = BreedsService(urlSession: urlSession)
        let sut = DogBreedsNetworkProvider(breedsService: service)
        
        // WHEN
        do {
            _ = try await sut.fetchAllBreedsList()
            XCTFail("Unexpected response")
        } catch {
            print(error)
            XCTAssertEqual(error as? DogBreedsNetworkProviderError, .general)
        }
    }
    
    func testFetchAllBreedsList_invalidData() async throws {
        // GIVEN
        let urlSession = MockURLSession(data: Data(), response: nil, error: nil)
        let service = BreedsService(urlSession: urlSession)
        let sut = DogBreedsNetworkProvider(breedsService: service)
        
        // WHEN
        do {
            _ = try await sut.fetchAllBreedsList()
            XCTFail("Unexpected response")
        } catch {
            print(error)
            XCTAssertEqual(error as? DogBreedsNetworkProviderError, .general)
        }
    }
    
    func testFetchDogImages_successfully() async throws {
        // GIVEN
        guard let url = Bundle.module.url(forResource: "DogImages", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
                  XCTFail("Could not load data from DogBreedsList.json")
                  return
              }
        let urlSession = MockURLSession(data: data, response: nil, error: nil)
        let service = BreedsService(urlSession: urlSession)
        let sut = DogBreedsNetworkProvider(breedsService: service)
        
        // WHEN
        do {
            let dictionary = try await sut.fetchImages(forBreed: "Test")
            XCTAssertEqual(dictionary.count, 1000)
        } catch {
            XCTFail("Invalid error")
        }
    }
    
    func testFetchDogImages_requestFailed() async throws {
        // GIVEN
        let urlSession = MockURLSession(data: nil, response: nil, error: BreedsServiceError.requestFailed)
        let service = BreedsService(urlSession: urlSession)
        let sut = DogBreedsNetworkProvider(breedsService: service)

        // WHEN
        do {
            _ = try await sut.fetchImages(forBreed: "Test")
            XCTFail("Unexpected response")
        } catch {
            print(error)
            XCTAssertEqual(error as? DogBreedsNetworkProviderError, .general)
        }
    }
    
    func testFetchDogImages_invalidData() async throws {
        // GIVEN
        let urlSession = MockURLSession(data: Data(), response: nil, error: nil)
        let service = BreedsService(urlSession: urlSession)
        let sut = DogBreedsNetworkProvider(breedsService: service)

        // WHEN
        do {
            _ = try await sut.fetchImages(forBreed: "Test")
            XCTFail("Unexpected response")
        } catch {
            print(error)
            XCTAssertEqual(error as? DogBreedsNetworkProviderError, .general)
        }
    }
}
