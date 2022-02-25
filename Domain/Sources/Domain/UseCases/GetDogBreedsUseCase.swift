//
//  GetDogBreedsUseCase.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public protocol GetDogBreedUseCaseContract {
    func execute() async
}

public final class GetDogBreedsUseCase {
    private let breedsNetworkProvider: DogBreedsNetworkProviderContract
    
    // MARK: - Initializer
    public init(breedsNetworkProvider: DogBreedsNetworkProviderContract) {
        self.breedsNetworkProvider = breedsNetworkProvider
    }
}

// MARK: - GetDogBreedUseCaseContract
extension GetDogBreedsUseCase: GetDogBreedUseCaseContract {
    public func execute() async {
        await breedsNetworkProvider.fetchAllBreedsList()
    }
}
