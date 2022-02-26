//
//  DogBreedsListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI
import Domain

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var selectedDogBreed: DogBreed?
    @State private var isRouteSet = false
    
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
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
                    case let .render(breeds):
                        DogBreedsListView(selectedBreed: $selectedDogBreed, breeds: breeds)
                    case .error:
                        errorView
                    }
                }
                
                NavigationLink(isActive: $isRouteSet) {
                    if let destinationRoute = viewModel.destinationRoute {
                        switch destinationRoute {
                        case .images:
                            Text("Images")
                        case .subBreeds:
                            Text("SubBreeds")
                        default:
                            EmptyView()
                        }
                    } else {
                        EmptyView()
                    }
                } label: {
                    EmptyView()
                }

            }
            .navigationTitle("Dog Breeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Favorites") {
                        print("User tapped favorites")
                    }
                    .foregroundColor(.yellow)
                }
            }
        }
        .preferredColorScheme(.dark)
        .task {
            await setupSubscriptions()
        }
        .onChange(of: selectedDogBreed, perform: toggleSelectedDogState)
        .onChange(of: viewModel.destinationRoute) { newValue in
            isRouteSet = newValue != nil
        }
    }
}

// MARK: - Setup subscriptions
private extension MainView {
    private func setupSubscriptions() async {
        let input = MainViewModel.Input(retryButtonTapPublisher: errorView.retryButtonTapPublisher)
        await viewModel.bind(input)
    }
    
    private func toggleSelectedDogState(_ breed: DogBreed?) {
        if let breed = breed {
            Task {
                viewModel.didSelectDogBreed(breed)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
