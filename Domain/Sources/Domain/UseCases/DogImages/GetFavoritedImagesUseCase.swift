//
//  GetFavoritedImagesUseCase.swift
//  
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation

public protocol GetFavoritedImagesUseCaseContract {
    func execute() -> [BreedImage]
}

public final class GetFavoritedImagesUseCase {
    private let dogBreedsPersistedProvider: DogBreedsPersistedProviderContract
    
    // MARK: - Initializer
    public init(dogBreedsPersistedProvider: DogBreedsPersistedProviderContract) {
        self.dogBreedsPersistedProvider = dogBreedsPersistedProvider
    }
}

// MARK: - GetFavoritedImagesUseCaseContract
extension GetFavoritedImagesUseCase: GetFavoritedImagesUseCaseContract {
    public func execute() -> [BreedImage] {
        dogBreedsPersistedProvider.getFavoritedImages()
    }
}
