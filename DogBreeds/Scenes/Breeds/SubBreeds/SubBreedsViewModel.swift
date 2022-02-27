//
//  SubBreedsViewModel.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation
import Domain

@MainActor class SubBreedsViewModel: ObservableObject {
    private var dogFamily: DogFamily?
    
    @Published var familyName = ""
    @Published var subBreeds: [DogBreed] = []
    
    // MARK: - Initializer
    init(dogFamily: DogFamily) {
        self.dogFamily = dogFamily
        
        familyName = dogFamily.name
        subBreeds = dogFamily.breeds
    }
}
