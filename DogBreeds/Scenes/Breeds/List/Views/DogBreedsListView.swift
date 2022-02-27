//
//  DogBreedsListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI
import Domain

struct DogBreedsListView: View {
    @Binding var selectedBreed: DogFamily?
    @State private var searchText = ""
    
    var breeds: [DogFamily]
    
    private var searchResults: [DogFamily] {
        if searchText.isEmpty {
            return breeds
        } else {
            return breeds.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(searchResults) { breed in
                HStack {
                    Text(breed.name.capitalized)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedBreed = breed
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct DogBreedsListView_Previews: PreviewProvider {
    static var breeds: [DogFamily] = [
        DogFamily(name: "Mountain Beranaise", breeds: [])
    ]
    static var previews: some View {
        DogBreedsListView(selectedBreed: .constant(Self.breeds.first!),
                          breeds: Self.breeds)
    }
}
