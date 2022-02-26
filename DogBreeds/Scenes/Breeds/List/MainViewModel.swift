//
//  BreedsListViewModel.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation
import Injector
import Combine
import Domain

@MainActor class MainViewModel: ObservableObject {
    @Injected private var fetchDogBreedsUseCase: FetchDogBreedsFromLocalOrRemoteUseCaseContract
    
    private var dogBreeds: [DogBreed] = []
    private var subscriptions = Set<AnyCancellable>()
    
    private let router: MainRouterContract
    
    @Published var viewState = ViewState.notStarted
    @Published var destinationRoute: MainRouter.Route?
    
    // MARK: - Initializer
    init(router: MainRouterContract = MainRouter()) {
        self.router = router
    }
}

// MARK: - View State
extension MainViewModel {
    enum ViewState {
        case notStarted
        case loading
        case render([DogBreed])
        case error
    }
}

// MARK: - Private methods
private extension MainViewModel {
    private func getDogBreeds() async throws {
        viewState = .loading
        
        do {
            dogBreeds = try await fetchDogBreedsUseCase.execute()
            sortMainDogBreeds()
        } catch {
            viewState = .error
        }
    }
    
    private func sortMainDogBreeds() {
//        let mainDogBreeds = dogBreeds.filter { $0.name == $0.breedFamily }.sorted(by: { $0.name < $1.name })
        var mainDogBreeds: [DogBreed] = []
        for breed in dogBreeds.sorted(by: { $0.name < $1.name }) {
            print(breed)
        }
        viewState = .render(mainDogBreeds)
    }
}

// MARK: - MainViewModelContract
extension MainViewModel {
    struct Input {
        let retryButtonTapPublisher: AnyPublisher<Void, Never>
    }
    
    func bind(_ input: Input) async {
        try? await getDogBreeds()
        
        input.retryButtonTapPublisher
            .sink { _ in
                Task {
                    try? await self.getDogBreeds()
                }
            }
            .store(in: &subscriptions)
    }
    
    func didSelectDogBreed(_ breed: DogBreed) {
        destinationRoute = router.getRouteForBreed(breed)
    }
}
