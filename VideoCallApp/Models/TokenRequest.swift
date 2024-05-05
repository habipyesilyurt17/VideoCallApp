//
//  TokenRequest.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 5.05.2024.
//

import Foundation

struct TokenRequest: Encodable {
    let tokenType: String
    let channel: String
    let role: String?
    let uid: String
}
