//
//  DogBreedsListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI

struct DogBreedsListView: View {
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    @StateObject var viewModel = DogBreedsListViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.viewState {
                case .notStarted:
                    EmptyView()
                case .loading:
                    loadingView
                case let .render(breeds):
                    List {
                        ForEach(breeds, id: \.name) { breed in
                            Text(breed.name.capitalized)
                        }
                    }
                case .error:
                    errorView
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
    }
}

// MARK: - Setup subscriptions
private extension DogBreedsListView {
    private func setupSubscriptions() async {
        let input = DogBreedsListViewModel.Input(retryButtonTapPublisher: errorView.retryButtonTapPublisher)
        await viewModel.bind(input)
    }
}

struct DogBreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedsListView()
    }
}
