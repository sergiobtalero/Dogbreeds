//
//  BreedsListViewModel.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation
import Injector
import Domain

@MainActor class DogBreedsListViewModel: ObservableObject {
    @Injected private var fetchDogBreedsUseCase: FetchDogBreedsFromLocalOrRemoteUseCaseContract
    
    private var dogBreeds: [DogBreed] = []
    
    @Published var viewState = ViewState.loading
}

// MARK: - View State
extension DogBreedsListViewModel {
    enum ViewState {
        case loading
        case render([DogBreed])
        case error
    }
}

// MARK: - Public methods
extension DogBreedsListViewModel {
    func getDogBreeds() async throws {
        do {
            dogBreeds = try await fetchDogBreedsUseCase.execute()
            sortMainDogBreeds()
        } catch {
            viewState = .error
        }
    }
}

// MARK: - Private methods
private extension DogBreedsListViewModel {
    private func sortMainDogBreeds() {
        let mainDogBreeds = dogBreeds.filter { $0.name == $0.breedFamily }.sorted(by: { $0.name < $1.name })
        viewState = .render(mainDogBreeds)
    }
}
