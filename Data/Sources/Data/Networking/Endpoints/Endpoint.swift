//
//  Endpoint.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: [String: String] { get }
}
