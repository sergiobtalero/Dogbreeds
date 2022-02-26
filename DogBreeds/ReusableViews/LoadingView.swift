//
//  LoadingView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Loading")
                    .font(.title2)
                Text("Please wait")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
