//
//  DogBreedsListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI
import Combine
import Domain

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var selectedDogFamily: DogFamily?
    @State private var isRouteSet = false
    @State private var showFavorites = false
    
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    private let didSelectDogPublisher = PassthroughSubject<DogFamily, Never>()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    switch viewModel.viewState {
                    case .notStarted:
                        EmptyView()
                    case .loading:
                        loadingView
                    case let .render(dogFamilies):
                        DogBreedsListView(selectedBreed: $selectedDogFamily, breeds: dogFamilies)
                            
                    case .error:
                        errorView
                    }
                }
                
                NavigationLink(isActive: $isRouteSet) {
                    getDestinationView()
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $showFavorites) {
                    FavoritesView()
                } label: {
                    EmptyView()
                }
            }
            .navigationTitle("Dog Breeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Favorites") {
                        showFavorites = true
                    }
                    .foregroundColor(.yellow)
                }
            }
        }
        .preferredColorScheme(.dark)
        .task {
            await setupSubscriptions()
        }
        .onChange(of: selectedDogFamily) { _ in
            if let selectedDogFamily = selectedDogFamily {
                didSelectDogPublisher.send(selectedDogFamily)
            }
        }
        .onChange(of: viewModel.destinationRoute) { newValue in
            isRouteSet = newValue != nil
        }
    }
}

// MARK: - Setup subscriptions
private extension MainView {
    private func setupSubscriptions() async {
        let input = MainViewModel.Input(retryButtonTapPublisher: errorView.retryButtonTapPublisher,
                                        didSelectDogFamilyPublisher: didSelectDogPublisher.eraseToAnyPublisher())
        await viewModel.bind(input)
    }
    
    @ViewBuilder
    private func getDestinationView() -> some View {
        if let destinationRoute = viewModel.destinationRoute {
            switch destinationRoute {
            case .images:
                if let selectedDogFamily = selectedDogFamily {
                    BreedImagesView(breedName: selectedDogFamily.name,
                                    familyName: nil)
                        .onDisappear {
                            self.selectedDogFamily = nil
                        }
                } else {
                    EmptyView()
                }
            case .subBreeds:
                if let selectedDogFamily = selectedDogFamily {
                    SubBreedsView(family: selectedDogFamily)
                } else {
                    EmptyView()
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
