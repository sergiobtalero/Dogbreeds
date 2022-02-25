//
//  DogBreedsApp.swift
//  DogBreeds
//
//  Created by Sergio Bravo on 25/02/22.
//

import SwiftUI

@main
struct DogBreedsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
