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
    func getRouteForDogFamily(_ family: DogFamily) -> MainRouter.Route
}

final class MainRouter: MainRouterContract {
    func getRouteForDogFamily(_ family: DogFamily) -> Route {
        family.breeds.isEmpty ? .images(family) : .subBreeds(family)
    }
}

// MARK: - Routes
extension MainRouter {
    enum Route: Equatable {
        case images(DogFamily)
        case subBreeds(DogFamily)
        case favorites
        
        static func ==(lhs: Route, rhs: Route) -> Bool {
            switch (lhs, rhs) {
            case (.favorites, .favorites):
                return true
            case (let .images(dogFamilyA), let .images(dogFamilyB)):
                return dogFamilyA == dogFamilyB
            case (let .subBreeds(dogFamilyA), let .subBreeds(dogFamilyB)):
                return dogFamilyA == dogFamilyB
            default: return false
            }
        }
    }
}
