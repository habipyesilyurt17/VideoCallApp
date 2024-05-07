//
//  RegisterUserResponse.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 6.05.2024.
//

import Foundation

struct RegisterUserResponse: Codable {
    let action: String
    let application: String
    let path: String
    let uri: String
    let entities: [Entities]
    let timestamp: Int64
    let duration: Int
    let organization: String
    let applicationName: String
}

struct Entities: Codable {
    let uuid: String
    let type: String
    let created: Int64
    let modified: Int64
    let username: String
    let activated: Bool
}
