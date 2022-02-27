//
//  BreedImagesView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI

struct BreedImagesView: View {
    @StateObject private var viewModel: BreedImagesViewModel
    
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    // MARK: - Initializer
    init(breedName: String) {
        _viewModel = StateObject(wrappedValue: BreedImagesViewModel(breedName: breedName))
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                loadingView
            case .error:
                errorView
            case let .render(breedImages):
                ImagesListView(images: breedImages)
            }
        }
        .navigationTitle("Images")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await setupSubscriptions()
            }
        }
    }
}

// MARK: - Private methods
private extension BreedImagesView {
    private func setupSubscriptions() async {
        let input = BreedImagesViewModel.Input(retryButtonTapPublisher: errorView.retryButtonTapPublisher)
        await viewModel.bind(input)
    }
}

struct BreedImagesView_Previews: PreviewProvider {
    static var previews: some View {
        BreedImagesView(breedName: "Husky")
    }
}
