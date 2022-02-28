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
    enum ViewState: Equatable {
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
    
    private func observeRetryButtonTapPublisher(_ publisher: AnyPublisher<Void, Never>) {
        publisher
            .sink { _ in
                Task {
                    try? await self.getDogBreeds()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func observeDidSelectDogFamilyPublisher(_ publisher: AnyPublisher<DogFamily, Never>) {
        publisher
            .sink { [weak self] selectedDogFamily in
                guard let self = self else { return }
                let newRoute = self.router.getRouteForDogFamily(selectedDogFamily,
                                                                 currentRoute: self.destinationRoute)
                self.destinationRoute = newRoute
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Public mehtods
extension MainViewModel {
    struct Input {
        let retryButtonTapPublisher: AnyPublisher<Void, Never>
        let didSelectDogFamilyPublisher: AnyPublisher<DogFamily, Never>
    }
    
    func bind(_ input: Input) async {
        try? await getDogBreeds()
        
        observeRetryButtonTapPublisher(input.retryButtonTapPublisher)
        observeDidSelectDogFamilyPublisher(input.didSelectDogFamilyPublisher)
    }
}
