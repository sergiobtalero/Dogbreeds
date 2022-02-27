//
//  FetchDogFamiliesDictionaryFromServiceUseCaseTests.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

@testable import Domain
import Injector
import XCTest

enum TestError: Error {
    case general
}

class FetchDogFamiliesDictionaryFromServiceUseCaseTests: XCTestCase {
    func testExecution_success() async throws {
        let mockProvider = MockDogBreedNetworkProvider(error: nil, dictionary: ["Test": ["Test", "Test"]], images: [])
        let sut = FetchDogFamiliesDictionaryFromServiceUseCase(breedsNetworkProvider: mockProvider)
        
        do {
            let response = try await sut.execute()
            XCTAssertTrue(!response.values.isEmpty)
        } catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testExecution_failure() async throws {
        let mockProvider = MockDogBreedNetworkProvider(error: TestError.general, dictionary: ["Test": ["Test", "Test"]], images: [])
        let sut = FetchDogFamiliesDictionaryFromServiceUseCase(breedsNetworkProvider: mockProvider)
        
        do {
            let response = try await sut.execute()
            XCTFail("Unexpected response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
