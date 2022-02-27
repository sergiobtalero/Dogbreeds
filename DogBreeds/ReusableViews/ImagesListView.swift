//
//  ImagesListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 27/02/22.
//

import SwiftUI
import Domain

struct ImagesListView: View {
    let images: [BreedImage]
    
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(images) { element in
                        AsyncImage(url: element.url) { image in
                            image
                                .resizable()
                                .frame(width: geometry.size.width - 10, height: geometry.size.width - 10)
                        } placeholder: {
                            Text("Loading")
                                .frame(width: geometry.size.width - 10, height: geometry.size.width - 10)
                        }
                        
                    }
                }
            }
        }
    }
}

struct ImagesListView_Previews: PreviewProvider {
    static let images: [BreedImage] = [
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10147.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10185.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10225.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10437.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10439.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10680.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10787.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10848.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10147.jpg")!, isFavorite: false),
        BreedImage(url: URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_10859.jpg")!, isFavorite: false)
    ]
    static var previews: some View {
        ImagesListView(images: Self.images)
    }
}
