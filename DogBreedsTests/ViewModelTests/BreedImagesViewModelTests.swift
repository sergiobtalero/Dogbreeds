//
//  BreedImagesViewModelTests.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

@testable import DogBreeds
import Injector
import Combine
import Domain
import XCTest

class BreedImagesViewModelTests: XCTestCase {
    var retryButtonTapPublisher: PassthroughSubject<Void, Never>!
    var likeButtonTapPublisher: PassthroughSubject<BreedImage, Never>!

    // MARK: - Setup
    override func setUpWithError() throws {
        DependencyContainer.removeAllDependencies()
        retryButtonTapPublisher = PassthroughSubject<Void, Never>()
        likeButtonTapPublisher = PassthroughSubject<BreedImage, Never>()
    }

    override func tearDownWithError() throws {
        retryButtonTapPublisher = nil
        likeButtonTapPublisher = nil
    }

    func testLoadImages_successfully() async throws {
        let fetchImagesUseCase = MockFetchDogImagesFromRemoteOrLocalUseCase(error: nil, images: BreedImage.testingData)
        let toggleImageFavoriteStatusUseCase = MockToggleLikeStatusOfDogImageUseCase(error: nil)
        
        DependencyContainer.register(fetchImagesUseCase as FetchDogImagesFromRemoteOrLocalUseCaseContract)
        DependencyContainer.register(toggleImageFavoriteStatusUseCase as ToggleLikeStatusOfDogImageUseCaseContract)
        
        let input = BreedImagesViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                               likeButtonTapPublisher: likeButtonTapPublisher.eraseToAnyPublisher())
        let viewModel = await BreedImagesViewModel(breedName: "Bernaise", familyName: "Mountain")
        
        await viewModel.bind(input)
        
        let sut = await viewModel.viewState
        
        if case let .render(images) = sut {
            XCTAssertEqual(images.count, BreedImage.testingData.count)
        } else {
            XCTFail("Invalid view state")
        }
    }

    func testLoadImages_failure() async throws {
        let fetchImagesUseCase = MockFetchDogImagesFromRemoteOrLocalUseCase(error: TestError.general, images: BreedImage.testingData)
        let toggleImageFavoriteStatusUseCase = MockToggleLikeStatusOfDogImageUseCase(error: nil)
        
        DependencyContainer.register(fetchImagesUseCase as FetchDogImagesFromRemoteOrLocalUseCaseContract)
        DependencyContainer.register(toggleImageFavoriteStatusUseCase as ToggleLikeStatusOfDogImageUseCaseContract)
        
        let input = BreedImagesViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                               likeButtonTapPublisher: likeButtonTapPublisher.eraseToAnyPublisher())
        let viewModel = await BreedImagesViewModel(breedName: "Bernaise", familyName: "Mountain")
        
        await viewModel.bind(input)
        
        let sut = await viewModel.viewState
        
        XCTAssertEqual(sut, .error)
    }

    func testRetryButtonTapped() async throws {
        let fetchImagesUseCase = MockFetchDogImagesFromRemoteOrLocalUseCase(error: TestError.general, images: BreedImage.testingData)
        let toggleImageFavoriteStatusUseCase = MockToggleLikeStatusOfDogImageUseCase(error: nil)
        
        DependencyContainer.register(fetchImagesUseCase as FetchDogImagesFromRemoteOrLocalUseCaseContract)
        DependencyContainer.register(toggleImageFavoriteStatusUseCase as ToggleLikeStatusOfDogImageUseCaseContract)
        
        let input = BreedImagesViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                               likeButtonTapPublisher: likeButtonTapPublisher.eraseToAnyPublisher())
        let viewModel = await BreedImagesViewModel(breedName: "Bernaise", familyName: "Mountain")
        
        await viewModel.bind(input)
        retryButtonTapPublisher.send(())
        
        let sut = await viewModel.viewState
        
        XCTAssertEqual(sut, .error)
    }
    
    func testLikeButtonTapped_success() async throws {
        let testImage = BreedImage.testingData
        let fetchImagesUseCase = MockFetchDogImagesFromRemoteOrLocalUseCase(error: nil, images: BreedImage.testingData)
        let toggleImageFavoriteStatusUseCase = MockToggleLikeStatusOfDogImageUseCase(error: nil)
        
        DependencyContainer.register(fetchImagesUseCase as FetchDogImagesFromRemoteOrLocalUseCaseContract)
        DependencyContainer.register(toggleImageFavoriteStatusUseCase as ToggleLikeStatusOfDogImageUseCaseContract)
        
        let input = BreedImagesViewModel.Input(retryButtonTapPublisher: retryButtonTapPublisher.eraseToAnyPublisher(),
                                               likeButtonTapPublisher: likeButtonTapPublisher.eraseToAnyPublisher())
        let viewModel = await BreedImagesViewModel(breedName: "Bernaise", familyName: "Mountain")
        
        await viewModel.bind(input)
        likeButtonTapPublisher.send(testImage.first!)
        let sut = await viewModel.viewState
        
        if case let .render(images) = sut {
            XCTAssertEqual(images.count, testImage.count)
        } else {
            XCTFail("Invalid view state")
        }
    }
}
