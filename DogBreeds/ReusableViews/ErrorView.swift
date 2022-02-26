//
//  ErrorView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Combine
import SwiftUI

struct ErrorView: View {
    var onRetryTap: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Oops")
                .font(.title2)
            Text("Something went wrong")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button {
                onRetryTap?()
            } label: {
                Text("Try again")
                    .foregroundColor(.yellow)
            }
            .padding(.top, 10)
        }
        .preferredColorScheme(.dark)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
