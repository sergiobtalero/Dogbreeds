//
//  File.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation

public protocol UpdateDogBreedWithImagesUseCaseContract {
    func execute(dogBreedName: String, images: [String])
}

public enum UpdateDogBreedWithImagesUseCaseError: Error {
    case general
}

public final class UpdateDogBreedWithImagesUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - UpdateDogBreedWithImagesUseCaseContract
extension UpdateDogBreedWithImagesUseCase: UpdateDogBreedWithImagesUseCaseContract {
    public func execute(dogBreedName: String, images: [String]) {
        try? dogBreedsPersistedProvider.addImages(images, dogBreedName: dogBreedName)
        try? dogBreedsPersistedProvider.addImages(images, dogFamilyName: dogBreedName)
    }
}
