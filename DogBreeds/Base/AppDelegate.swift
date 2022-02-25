//
//  AppDelegate.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation
import Injector
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DependencyContainer.registerUseCases()
        return true
    }
}
