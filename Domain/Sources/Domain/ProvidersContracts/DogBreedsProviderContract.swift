//
//  DogBreedsProviderContract.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

public enum DogBreedsNetworkProviderError: Error {}

public protocol DogBreedsNetworkProviderContract {
    func fetchAllBreedsList() async
    func fetchImages(forBreed breed: String) async
    func fetchSubBreeds(of breed: String) async
}
