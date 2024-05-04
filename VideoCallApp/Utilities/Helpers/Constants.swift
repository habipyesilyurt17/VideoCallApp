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
