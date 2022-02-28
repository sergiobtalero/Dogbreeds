//
//  SubBreedsViewModelTests.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

@testable import DogBreeds
import Combine
import Domain
import XCTest

class SubBreedsViewModelTests: XCTestCase {
    var didSelectSubBreedPublisher: PassthroughSubject<DogBreed, Never>!

    // MARK: - Setup
    override func setUpWithError() throws {
        didSelectSubBreedPublisher = PassthroughSubject<DogBreed, Never>()
    }

    override func tearDownWithError() throws {
        didSelectSubBreedPublisher = nil
    }

    func testDidSelectSubBreed_navigateTo_images() async throws {
        let dogFamily = DogFamily.testingData.first!
        let viewModel = await SubBreedsViewModel(dogFamily: dogFamily)
        let input = SubBreedsViewModel.Input(didSelectSubBreedPublisher: didSelectSubBreedPublisher.eraseToAnyPublisher())
        await viewModel.bind(input)
        didSelectSubBreedPublisher.send(dogFamily.breeds.first!)
        let sut = await viewModel.destinationRoute
        
        if case let .images(dogBreedName, isForceUpdate) = sut {
            XCTAssertEqual(dogBreedName, "Bernaise")
            XCTAssertFalse(isForceUpdate)
        } else {
            XCTFail("Invalid route")
        }
    }
}
