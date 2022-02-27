//
//  SubBreedsViewModel.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation
import Combine
import Domain

@MainActor class SubBreedsViewModel: ObservableObject {
    private var dogFamily: DogFamily?
    
    private let router: SubBreedsRouterContract
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var familyName = ""
    @Published var subBreeds: [DogBreed] = []
    @Published var destinationRoute: SubBreedsRouter.Route?
    
    // MARK: - Initializer
    init(dogFamily: DogFamily,
         router: SubBreedsRouterContract = SubBreedsRouter()) {
        self.dogFamily = dogFamily
        self.router = router
        
        familyName = dogFamily.name
        subBreeds = dogFamily.breeds
    }
}

// MARK: - Private methods
private extension SubBreedsViewModel {
    private func observeDidSelectSubBreedPublisher(_ publisher: AnyPublisher<DogBreed, Never>) {
        publisher
            .sink { [weak self] subBreed in
                guard let self = self else { return }
                let newRoute = self.router.getDestinationRoute(dogBreed: subBreed.name,
                                                               currentRoute: self.destinationRoute)
                self.destinationRoute = newRoute
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Public methods
extension SubBreedsViewModel {
    struct Input {
        let didSelectSubBreedPublisher: AnyPublisher<DogBreed, Never>
    }
    
    func bind(_ input: Input) {
        observeDidSelectSubBreedPublisher(input.didSelectSubBreedPublisher)
    }
}
