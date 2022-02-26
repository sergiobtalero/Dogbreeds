//
//  MainRouter.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation
import SwiftUI
import Domain

protocol MainRouterContract {
    func getRouteForBreed(_ breed: DogBreed) -> MainRouter.Route
}

final class MainRouter: MainRouterContract {
    func getRouteForBreed(_ breed: DogBreed) -> Route {
        return breed.name == breed.breedFamily ? .subBreeds : .images
    }
}

// MARK: - Routes
extension MainRouter {
    enum Route {
        case images
        case subBreeds
        case favorites
    }
}
