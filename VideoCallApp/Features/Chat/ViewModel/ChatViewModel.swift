//
//  ChatViewModel.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 6.05.2024.
//

import Foundation

final class ChatViewModel {
    var error: APIError?
    var token: String = ""
    
    func fetchToken(
        tokenType: String,
        channel: String,
        completion: @escaping () -> Void
    ) {
        TokenService(
            parameters: TokenRequest(
                tokenType: tokenType,
                channel: channel,
                role: nil,
                uid: "0"
            )
        ).call { response in
            self.error = nil
            self.token = response.token
            completion()
        } failure: { error in
            self.error = error
        }
    }
    
    func registerUser(
        username: String,
        password: String,
        token: String
    ) {
        ChatService(
            parameters: RegisterUserRequest(
                username: username,
                password: password
            )
        ).userRegister(token: token) { response in
            print("repsonse--\(response)")
            // kaydedilen user'a ait tokenı generate et, ilgili user için chat join de bu tokenı kullan
        } failure: { error in
            self.error = error
        }
    }
}
