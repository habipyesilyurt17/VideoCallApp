//
//  APIRequest.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 5.05.2024.
//

import Foundation

typealias CompletionHandler = (Data) -> Void
typealias FailureHandler = (APIError) -> Void

struct EmptyRequest: Encodable {}
struct EmptyResponse: Decodable {}

enum HTTPMethod: String {
    case get
    case put
    case delete
    case post
}

final class APIRequest<Parameters: Encodable, Model: Decodable> {
    
    static func call(
        scheme: String = Config.shared.scheme,
        host: String = Config.shared.host,
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        completion: @escaping CompletionHandler,
        failure: @escaping FailureHandler
    ) {
//        if !NetworkMonitor.shared.isReachable {
//            return failure(.noInternet)
//        }
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let parameters = parameters {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                completion(data)
            } else {
                if error != nil {
                    failure(APIError.response)
                }
            }
        }
        task.resume()
    }
}
