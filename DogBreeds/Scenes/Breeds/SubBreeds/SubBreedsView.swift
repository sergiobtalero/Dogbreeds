//
//  SubBreedsView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI
import Combine
import Domain

struct SubBreedsView: View {
    @StateObject private var viewModel: SubBreedsViewModel
    @State private var selectedBreed: DogBreed?
    @State private var isRouteSet = false
    
    private let didSelectSubBreedPublisher = PassthroughSubject<DogBreed, Never>()
    
    // MARK: - Initializer
    init(family: DogFamily) {
        _viewModel = StateObject(wrappedValue: SubBreedsViewModel(dogFamily: family))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.subBreeds) { subBreed in
                    HStack {
                        Text(subBreed.name.capitalized)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedBreed = subBreed
                    }
                }
            }
            
            NavigationLink(isActive: $isRouteSet) {
                if let selectedBreed = selectedBreed {
                    BreedImagesView(breedName: selectedBreed.name,
                                    familyName: selectedBreed.familyName)
                } else {
                    EmptyView()
                }
            } label: {
                EmptyView()
            }

        }
        .navigationTitle("\(viewModel.familyName.capitalized) Breeds")
        .navigationBarTitleDisplayMode(.inline)
        .task { await setupSubscriptions() }
        .onChange(of: selectedBreed) { _ in
            if let selectedBreed = selectedBreed {
                didSelectSubBreedPublisher.send(selectedBreed)
            }
        }
        .onChange(of: viewModel.destinationRoute) { newValue in
            isRouteSet = newValue != nil
        }
    }
}

// MARK: - Private methods
private extension SubBreedsView {
    private func setupSubscriptions() async {
        let input = SubBreedsViewModel.Input(didSelectSubBreedPublisher: didSelectSubBreedPublisher.eraseToAnyPublisher())
        viewModel.bind(input)
    }
}
