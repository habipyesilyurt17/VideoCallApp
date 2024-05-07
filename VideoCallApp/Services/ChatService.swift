//
//  ChatService.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 6.05.2024.
//

import Foundation

struct ChatService {
    let host = "\(ChatConstants.HOST)"
    let path = "/\(ChatConstants.ORG_NAME)/\(ChatConstants.APP_NAME)/users"
    let method: HTTPMethod = .post
    var parameters: RegisterUserRequest

    func userRegister(
        token: String,
        completion: @escaping (RegisterUserResponse) -> Void,
        failure: @escaping (APIError) -> Void
    ) {
        APIRequest<RegisterUserRequest, RegisterUserResponse>.call(
            host: host,
            path: path,
            method: .post,
            authorized: true,
            token: token,
            parameters: parameters
        ) { data in
            if let response = try? JSONDecoder().decode(
                RegisterUserResponse.self,
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
