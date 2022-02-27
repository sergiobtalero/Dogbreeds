//
//  SubBreedsRouter.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 27/02/22.
//

import Foundation
import Domain

protocol SubBreedsRouterContract {
    func getDestinationRoute(dogBreed: String, currentRoute: SubBreedsRouter.Route?) -> SubBreedsRouter.Route
}

final class SubBreedsRouter: SubBreedsRouterContract {
    func getDestinationRoute(dogBreed: String, currentRoute: SubBreedsRouter.Route?) -> Route {
        var newForceValue: Bool
       
        if case let .images(_, oldForceValue) = currentRoute {
            newForceValue = !oldForceValue
        } else {
            newForceValue = false
        }
        
        return .images(dogBreed, newForceValue)
    }
}

// MARK: - Routes
extension SubBreedsRouter {
    enum Route: Equatable {
        case images(String, Bool)
    }
}
