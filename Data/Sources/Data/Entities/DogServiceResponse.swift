//
//  DogServiceResponse.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

struct DogServiceResponse<T: Codable>: Codable {
    let message: T
}
