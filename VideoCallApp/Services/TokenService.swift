//
//  TokenService.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 5.05.2024.
//

import Foundation

struct TokenService {
    let path = "/getToken"
    let method: HTTPMethod = .post
    var parameters: TokenRequest
    
    func call(
        completion: @escaping (TokenResponse) -> Void,
        failure: @escaping (APIError) -> Void
    ) {
        APIRequest<TokenRequest, TokenResponse>.call(
            path: path,
            method: .post,
            parameters: parameters
        ) { data in
            if let response = try? JSONDecoder().decode(
                TokenResponse.self,
                from: data
            ) {
                completion(response)
            } else {
                failure(.jsonDecoding)
            }
        } failure: { error in
            failure(error)
        }
    }
}
