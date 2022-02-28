//
//  GetDogImagesFromServiceUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import XCTest

class GetDogImagesFromServiceUseCaseTests: XCTestCase {
    func testExecution_successful() async throws {
        let images = ["http://www.test.com", "http://www.test2.com", "http://www.test3.com"]
        let provider = MockDogBreedNetworkProvider(error: nil, dictionary: [:], images: images)
        let sut = GetDogImagesFromServiceUseCase(breedsNetworkProvider: provider)
        let response = try await sut.execute(breedName: "Test")
        XCTAssertEqual(response.count, 3)
    }
    
    func testExecution_failure() async throws {
        let images = ["http://www.test.com", "http://www.test2.com", "http://www.test3.com"]
        let provider = MockDogBreedNetworkProvider(error: TestError.general, dictionary: [:], images: images)
        let sut = GetDogImagesFromServiceUseCase(breedsNetworkProvider: provider)
        do {
            let response = try await sut.execute(breedName: "Test")
            XCTFail("Unexpected response")
        } catch {
            XCTAssertEqual(error as? TestError, .general)
        }
    }
}
