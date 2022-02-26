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
    @Injected private var fetchDogBreedsUseCase: FetchDogBreedsFromLocalOrRemoteUseCaseContract
    
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
        do {
            dogBreeds = try await fetchDogBreedsUseCase.execute()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
