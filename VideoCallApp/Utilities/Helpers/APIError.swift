//
//  APIError.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 5.05.2024.
//

import Foundation

enum APIError: String, Error {
    case jsonDecoding
    case response
    case noInternet
}
