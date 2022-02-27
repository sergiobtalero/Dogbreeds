//
//  BreedImagesView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI

struct BreedImagesView: View {
    @StateObject private var viewModel: BreedImagesViewModel
    
    init(breedName: String) {
        _viewModel = StateObject(wrappedValue: BreedImagesViewModel(breedName: breedName))
    }
    
    // MARK: - Body
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BreedImagesView_Previews: PreviewProvider {
    static var previews: some View {
        BreedImagesView(breedName: "Husky")
    }
}
