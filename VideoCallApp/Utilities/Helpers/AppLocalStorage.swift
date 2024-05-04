//
//  AppLocalStorage.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 4.05.2024.
//

import Foundation

final class AppLocalStorage {
    enum Key: String, CaseIterable {
        case name, avatarData
        func make(for userID: String) -> String {
            return self.rawValue + "_" + userID
        }
    }
    
    static let shared = AppLocalStorage()
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveValue(forKey key: String, value: Any) {
        userDefaults.set(value, forKey: key)
    }
    
    func readValue<T>(forKey key: String) -> T? {
        userDefaults.value(forKey: key) as? T
    }
}
