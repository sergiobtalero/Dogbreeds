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
    @Injected private var fetchDogBreedsUseCase: FetchDogFamiliesFromLocalOrRemoteUseCaseContract
    
    private var dogFamilies: [DogFamily] = []
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
        case render([DogFamily])
        case error
    }
}

// MARK: - Private methods
private extension MainViewModel {
    private func getDogBreeds() async throws {
        viewState = .loading
        
        do {
            dogFamilies = try await fetchDogBreedsUseCase.execute()
            sortMainDogBreeds()
        } catch {
            viewState = .error
        }
    }
    
    private func sortMainDogBreeds() {
        let sortedDogFamilies = dogFamilies.sorted(by: { $0.name < $1.name })
        viewState = .render(sortedDogFamilies)
    }
}

// MARK: - Public mehtods
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
    
    func didSelectDogFamily(_ family: DogFamily) {
        let newRoute = router.getRouteForDogFamily(family, currentRoute: destinationRoute)
        destinationRoute = newRoute
    }
}
