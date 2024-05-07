//
//  RegisterUserRequest.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 6.05.2024.
//

import Foundation

struct RegisterUserRequest: Encodable {
    let username: String
    let password: String
}
