//
//  ContentView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 25/02/22.
//

import Injector
import SwiftUI
import Domain

struct ContentView: View {
    @Injected private var fetchDogBreedsUseCase: FetchDogBreedsDictionaryFromServiceUseCaseContract
    @Injected private var getPersistedDogBreedsUseCase: GetPersistedDogBreedsUseCaseContract
    @Injected private var storeDogBreedsUseCase: StoreDogBreedsUseCaseContract
    
    @State private var dogBreeds: [DogBreed] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dogBreeds, id: \.name) { breed in
                    Text(breed.name)
                }
            }
            .navigationTitle("Dog Breeds")
        }
        .task {
            _ = try? await loadInitialData()
        }
    }
    
    func loadInitialData() async throws {
        let savedDogBreeds = getPersistedDogBreedsUseCase.execute()
        
        if !savedDogBreeds.isEmpty {
            dogBreeds = savedDogBreeds
            let families = Set<String>(dogBreeds.map { $0.breedFamily })
            return
        }
        
        let dogBreedsDictionary = try? await fetchDogBreedsUseCase.execute()
        
        guard let dogBreedsDictionary = dogBreedsDictionary else {
            print("Oops")
            return
        }
        
        try? storeDogBreedsUseCase.execute(dictionary: dogBreedsDictionary)
        dogBreeds = getPersistedDogBreedsUseCase.execute()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
