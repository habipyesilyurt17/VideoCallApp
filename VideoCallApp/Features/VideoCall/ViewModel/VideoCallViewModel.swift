//
//  VideoCallViewModel.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 5.05.2024.
//

import Foundation
import AgoraRtcKit

final class VideoCallViewModel {

    var error: APIError?
    var token: String = ""

    func fetchToken(
        tokenType: String,
        channel: String,
        role: AgoraClientRole,
        completion: @escaping () -> Void
    ) {
        TokenService(
            parameters: TokenRequest(
                tokenType: tokenType,
                channel: channel,
                role: role == .broadcaster ? "publisher" : "subscriber",
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
}
