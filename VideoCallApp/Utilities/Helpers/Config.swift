//
//  Config.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 5.05.2024.
//

import Foundation

final class Config {
    static let shared = Config()

    private init(){}
    
    let scheme: String = "https"
    let host: String = "agora-token-service-production-d0fa.up.railway.app"
}
