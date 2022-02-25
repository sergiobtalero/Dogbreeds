//
//  BreedsEndpoint.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

enum BreedsEndpoint: Endpoint {
    case list
    
    var path: String {
        switch self {
        case .list: return "/breeds/list/all"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .list: return .get
        }
    }
    
    var httpHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
