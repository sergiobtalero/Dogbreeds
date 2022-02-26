//
//  DogBreedsListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI

struct DogBreedsListView: View {
        @StateObject var viewModel = DogBreedsListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.viewState {
                case .loading:
                    Text("Loading.\nPlease wait")
                case let .render(breeds):
                    List {
                        ForEach(breeds, id: \.name) { breed in
                            Text(breed.name.uppercased())
                        }
                    }
                case .error:
                    Text("Something went wrong")
                }
            }
            .navigationTitle("Dog Breeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Favorites") {
                        print("User tapped favorites")
                    }
                }
            }
        }
        .task {
            _ = try? await viewModel.getDogBreeds()
        }
    }
}

struct DogBreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedsListView()
    }
}
