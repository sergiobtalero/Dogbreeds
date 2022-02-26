//
//  DogBreedsListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI
import Domain

struct DogBreedsListView: View {
    @Binding var selectedBreed: DogBreed?
    
    var breeds: [DogBreed]
    
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
    static var breeds: [DogBreed] = [
        DogBreed(name: "Mountain Bernaise", breedFamily: "Mountain Bernaise", images: []),
        DogBreed(name: "German Sheppard", breedFamily: "German Sheppard", images: [])
    ]
    static var previews: some View {
        DogBreedsListView(selectedBreed: .constant(Self.breeds.first!),
                          breeds: Self.breeds)
    }
}
