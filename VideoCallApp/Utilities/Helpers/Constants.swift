//
//  Constants.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 4.05.2024.
//

import Foundation

struct LocalStorageKeys {
    static let USER_NAME = "USER_NAME"
    static let IS_USER_NAME_CREATED = "IS_USER_NAME_CREATED"
}

struct ValidationErrors {
    static let MUST_BE_AT_LEAST_6_CHARACTERS_LONG = "Username must be at least 6 characters long."
    static let MUST_CONTAIN_AT_LEAST_ONE_LETTER = "Username must contain at least one letter."
    static let MUST_CONTAIN_AT_LEAST_ONE_DIGIT = "Username must contain at least one digit."
}

struct VideoCallConstants {
    static let APP_ID = "6758a3ca238442bc817733de2d6c8014"
    static let CHANNEL_NAME = "my-bobo-channel-test-on"
}

struct ChatConstants {
    static let APP_KEY = "611142780#1328118"
    static let ORG_NAME = "611142780"
    static let APP_NAME = "1328118"
    static let HOST = "a61.chat.agora.io"
}
