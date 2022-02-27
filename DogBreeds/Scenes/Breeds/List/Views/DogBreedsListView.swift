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
    
    var breeds: [DogFamily]
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(breeds) { breed in
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
