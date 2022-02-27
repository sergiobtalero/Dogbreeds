//
//  SubBreedsView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI
import Domain

struct SubBreedsView: View {
    @StateObject private var viewModel: SubBreedsViewModel
    
    // MARK: - Initializer
    init(family: DogFamily) {
        _viewModel = StateObject(wrappedValue: SubBreedsViewModel(dogFamily: family))
    }
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(viewModel.subBreeds) { subBreed in
                Text(subBreed.name.capitalized)
            }
        }
        .navigationTitle("SubBreeds of \(viewModel.familyName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SubBreedsView_Previews: PreviewProvider {
    static var previews: some View {
//        SubBreedsView()
        Text("")
    }
}
