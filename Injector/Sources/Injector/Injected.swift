//
//  Injected.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

import Foundation

@propertyWrapper
public struct Injected<T> {
    public var wrappedValue: T

    public init() {
        self.wrappedValue = DependencyContainer.resolve()
    }
}
