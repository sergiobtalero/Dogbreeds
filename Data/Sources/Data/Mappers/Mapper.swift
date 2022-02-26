//
//  Mapper.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output
    
    static func map(input: Input) -> Output
}
