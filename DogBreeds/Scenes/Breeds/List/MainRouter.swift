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
    func getRouteForDogFamily(_ family: DogFamily, currentRoute: MainRouter.Route?) -> MainRouter.Route
}

final class MainRouter: MainRouterContract {
    func getRouteForDogFamily(_ family: DogFamily,
                              currentRoute: Route?) -> Route {
//        guard let currentRoute = currentRoute else {
//            return family.breeds.isEmpty ? .images(family, true) : .subBreeds(family, true)
//        }
        
        var newForceValue: Bool
        if case let .images(_, oldForceValue) = currentRoute {
            newForceValue = !oldForceValue
        } else if case let .subBreeds(_, oldForceValue) = currentRoute {
            newForceValue = !oldForceValue
        } else {
            newForceValue = true
        }
        
        return family.breeds.isEmpty ? .images(family, newForceValue) : .subBreeds(family, newForceValue)
    }
}

// MARK: - Routes
extension MainRouter {
    enum Route: Equatable {
        case images(DogFamily, Bool)
        case subBreeds(DogFamily, Bool)
        case favorites(Bool)
        
        static func ==(lhs: Route, rhs: Route) -> Bool {
            switch (lhs, rhs) {
            case (.favorites, .favorites):
                return true
            case (let .images(dogFamilyA, forceValueA), let .images(dogFamilyB, forceValueB)):
                return dogFamilyA == dogFamilyB && forceValueA == forceValueB
            case (let .subBreeds(dogFamilyA, forceValueA), let .subBreeds(dogFamilyB, forceValueB)):
                return dogFamilyA == dogFamilyB && forceValueA == forceValueB
            default: return false
            }
        }
    }
}
