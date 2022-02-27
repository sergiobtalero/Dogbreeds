//
//  ImagesListView.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 27/02/22.
//

import SwiftUI
import Combine
import Domain

struct ImagesListView: View {
    @Binding var images: [BreedImage]
    
    let likeTapPublisher: PassthroughSubject<BreedImage, Never>
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(images) { element in
                        ZStack(alignment: .topTrailing) {
                            AsyncImage(url: element.url) { image in
                                image
                                    .resizable()
                                    .frame(width: getImageWidth(geometry: geometry),
                                           height: getImageWidth(geometry: geometry))
                            } placeholder: {
                                Text("Loading")
                                    .frame(width: getImageWidth(geometry: geometry),
                                           height: getImageWidth(geometry: geometry))
                            }
                            
                            Button {
                                likeTapPublisher.send(element)
                            } label: {
                                Image(systemName: element.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 20))
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal, 5)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Private methods
private extension ImagesListView {
    private func getImageWidth(geometry: GeometryProxy) -> CGFloat {
        geometry.size.width / 2 - 10
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
        ImagesListView(images: .constant(Self.images), likeTapPublisher: PassthroughSubject<BreedImage, Never>())
    }
}
