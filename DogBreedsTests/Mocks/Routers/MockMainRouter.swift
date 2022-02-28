//
//  MockMainRouter.swift
//  DogBreedsTests
//
//  Created by Sergio Bravo on 28/02/22.
//

@testable import DogBreeds
import Foundation
import Domain

class MockMainRouter: MainRouterContract {
    func getRouteForDogFamily(_ family: DogFamily,
                              currentRoute: MainRouter.Route?) -> MainRouter.Route {
        return .images(DogFamily(name: "", breeds: []), true)
    }
}
