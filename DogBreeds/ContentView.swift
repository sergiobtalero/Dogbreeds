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
    @Injected private var getDogBreedsUseCase: GetDogBreedUseCaseContract
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .task {
                await getDogBreedsUseCase.execute()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
