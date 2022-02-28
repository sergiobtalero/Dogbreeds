//
//  MainViewModelTests.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

@testable import DogBreeds
import Injector
import Combine
import Domain
import XCTest

class MainViewModelTests: XCTestCase {
    var router: MockMainRouter!
    
    let retryButtonTapPublisher = PassthroughSubject<Void, Never>()
    let didSelectDogFamilyPublisher = PassthroughSubject<DogFamily, Never>()

    override func setUpWithError() throws {
        DependencyContainer.removeAllDependencies()
        router = MockMainRouter()
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testLoadData_success() async throws {
        let fetchDogFamiliesUseCase = MockFetchDogFamiliesFromLocalOrRemoteUseCase(error: nil,
                                                                                   dogFamilies: DogFamily.testingData)
        DependencyContainer.register(fetchDogFamiliesUseCase as FetchDogFamiliesFromLocalOrRemoteUseCaseContract)
        
        let input = MainViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                        didSelectDogFamilyPublisher: didSelectDogFamilyPublisher.eraseToAnyPublisher())
        let sut = await MainViewModel(router: router)
        await sut.bind(input)
        let viewState = await sut.viewState
        
        if case let .render(data) = viewState {
            XCTAssertEqual(data.count, DogFamily.testingData.count)
        } else {
            XCTFail("Invalid state")
        }
    }
    
    func testLoadData_failure() async throws {
        let fetchDogFamiliesUseCase = MockFetchDogFamiliesFromLocalOrRemoteUseCase(error: TestError.general,
                                                                                   dogFamilies: DogFamily.testingData)
        DependencyContainer.register(fetchDogFamiliesUseCase as FetchDogFamiliesFromLocalOrRemoteUseCaseContract)
        
        let input = MainViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                        didSelectDogFamilyPublisher: didSelectDogFamilyPublisher.eraseToAnyPublisher())
        let sut = await MainViewModel(router: router)
        await sut.bind(input)
        let viewState = await sut.viewState
        
        XCTAssertEqual(viewState, .error)
    }
    
    func testRetryGetData() async throws {
        let fetchDogFamiliesUseCase = MockFetchDogFamiliesFromLocalOrRemoteUseCase(error: TestError.general,
                                                                                   dogFamilies: DogFamily.testingData)
        DependencyContainer.register(fetchDogFamiliesUseCase as FetchDogFamiliesFromLocalOrRemoteUseCaseContract)
        
        let input = MainViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                        didSelectDogFamilyPublisher: didSelectDogFamilyPublisher.eraseToAnyPublisher())
        let sut = await MainViewModel(router: router)
        await sut.bind(input)
        retryButtonTapPublisher.send(())
        
        let viewState = await sut.viewState
        
        XCTAssertEqual(viewState, .error)
    }
    
    func testDidSelectDogFamily() async throws {
        let dogFamilies = DogFamily.testingData
        let fetchDogFamiliesUseCase = MockFetchDogFamiliesFromLocalOrRemoteUseCase(error: TestError.general,
                                                                                   dogFamilies: dogFamilies)
        DependencyContainer.register(fetchDogFamiliesUseCase as FetchDogFamiliesFromLocalOrRemoteUseCaseContract)
        
        let input = MainViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                        didSelectDogFamilyPublisher: didSelectDogFamilyPublisher.eraseToAnyPublisher())
        let viewModel = await MainViewModel(router: MainRouter())
        await viewModel.bind(input)
        didSelectDogFamilyPublisher.send(dogFamilies.first!)
        
        let sut = await viewModel.destinationRoute
        
        if case let .subBreeds(dogFamily, forceValue) = sut {
            XCTAssertTrue(forceValue)
            XCTAssertEqual(dogFamily.name, "Mountain")
        } else {
            XCTFail("Invalid route")
        }
    }
}
