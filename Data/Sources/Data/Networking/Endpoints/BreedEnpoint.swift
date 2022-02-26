//
//  File.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

enum BreedEndpoint: Endpoint {
    case images(String)
    
    var path: String {
        switch self {
        case let .images(dogBreed): return "/breed/\(dogBreed)/hound/images"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .images: return .get
        }
    }
    
    var httpHeaders: [String : String] {
        return ["Content-Type": "application/json"]
    }
}
