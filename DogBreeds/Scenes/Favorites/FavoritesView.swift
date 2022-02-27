//
//  FavoritesView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 27/02/22.
//

import SwiftUI
import Combine
import Domain

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    @State var images: [BreedImage] = []
    
    private let toggleFavoritedStatusOfImagePublisher = PassthroughSubject<BreedImage, Never>()
    
    // MARK: - Initializer
    init() {
        _viewModel = StateObject(wrappedValue: FavoritesViewModel())
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .empty:
                NoResultsView()
            case .render:
                VStack {
                    ImagesListView(images: $images,
                                   likeTapPublisher: toggleFavoritedStatusOfImagePublisher)
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .task { await setupSubscriptions() }
        .onChange(of: viewModel.viewState) { newValue in
            if case let .render(breedImages) = newValue {
                images = breedImages
            }
        }
    }
}

// MARK: - Private methods
private extension FavoritesView {
    private func setupSubscriptions() async {
        let input = FavoritesViewModel.Input(toggleFavoritedStatusOfImagePublisher: toggleFavoritedStatusOfImagePublisher.eraseToAnyPublisher())
        viewModel.bind(input)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
