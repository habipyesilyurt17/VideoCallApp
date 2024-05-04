//
//  LoginViewModel.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 3.05.2024.
//

import UIKit

final class LoginViewModel {
    
    var errorMessage: String?
    
    func validateUsername(_ username: String) -> Bool {
        guard username.count >= 6 else {
            errorMessage = ValidationErrors.MUST_BE_AT_LEAST_6_CHARACTERS_LONG
            return false
        }
        
        let letterCharacterSet = CharacterSet.letters
        guard username.rangeOfCharacter(from: letterCharacterSet) != nil else {
            errorMessage = ValidationErrors.MUST_CONTAIN_AT_LEAST_ONE_LETTER
            return false
        }
        
        let digitCharacterSet = CharacterSet.decimalDigits
        guard username.rangeOfCharacter(from: digitCharacterSet) != nil else {
            errorMessage = ValidationErrors.MUST_CONTAIN_AT_LEAST_ONE_DIGIT
            return false
        }
        
        errorMessage = nil
        return true
    }
    
    func saveUsername(_ username: String) {
        AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.USER_NAME, value: username)
        AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.IS_USER_NAME_CREATED, value: true)
    }
}
