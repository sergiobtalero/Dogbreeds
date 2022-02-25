//
//  BreedsService.swift
//  
//
//  Created by Sergio Bravo on 25/02/22.
//

import Foundation

protocol BreedsServiceContract {
    func request<T: Decodable>(endpoint: Endpoint) async throws ->  T
}

public enum BreedsServiceError: Error {
    case invalidURL
    case requestFailed
    case parsingFailed
    case invalidData
}

final class BreedsService {
    private let urlSession: URLSession
    private let baseURL = "https://dog.ceo/api"
    
    // MARK: - Initializer
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

// MARK: - BreedsServiceContract
extension BreedsService: BreedsServiceContract {
    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        guard let url = URL(string: "\(baseURL)\(endpoint.path)") else {
            throw BreedsServiceError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        
        if !endpoint.httpHeaders.isEmpty {
            endpoint.httpHeaders.forEach { header in
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        return try await withCheckedThrowingContinuation({ continuation in
            let dataTask = urlSession.dataTask(with: urlRequest) { data, _, error in
                if error != nil {
                    continuation.resume(throwing: BreedsServiceError.requestFailed)
                    return
                }
                
                guard let data = data else {
                    continuation.resume(throwing: BreedsServiceError.invalidData)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let response = try jsonDecoder.decode(T.self, from: data)
                    continuation.resume(returning: response)
                } catch {
                    continuation.resume(throwing: BreedsServiceError.parsingFailed)
                }
            }
            dataTask.resume()
        })
    }
}
