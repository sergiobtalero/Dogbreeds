//
//  BreedImagesView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI
import Domain
import Combine

struct BreedImagesView: View {
    @StateObject private var viewModel: BreedImagesViewModel
    @State var images: [BreedImage] = []
    
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    private var likeTapPublisher = PassthroughSubject<BreedImage, Never>()
    
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
                makeImagesListView(breedImages: breedImages)
            }
        }
        .navigationTitle("Images")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await setupSubscriptions()
            }
        }
        .onChange(of: viewModel.viewState) { newValue in
            if case let .render(breedImages) = newValue {
                images = breedImages
            }
        }
    }
}

// MARK: - Private methods
private extension BreedImagesView {
    private func setupSubscriptions() async {
        let input = BreedImagesViewModel.Input(retryButtonTapPublisher: errorView.retryButtonTapPublisher,
                                               likeButtonTapPublisher: likeTapPublisher.eraseToAnyPublisher())
        await viewModel.bind(input)
    }
    
    private func makeImagesListView(breedImages: [BreedImage]) -> some View {
        let listView = ImagesListView(images: $images,
                                      likeTapPublisher: likeTapPublisher)
        return listView
    }
}

struct BreedImagesView_Previews: PreviewProvider {
    static var previews: some View {
        BreedImagesView(breedName: "Husky")
    }
}
