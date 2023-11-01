//
//  FirebaseToken.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import Foundation

enum FirebaseToken {
    
    private static let token = "FIREBASE_TOKEN"
    private static let sent = "FIREBASE_TOKEN_SENT"
    private static let defaults = UserDefaults.standard
    
    static func isValid(token: String) -> Bool {
        guard let savedToken = defaults.string(forKey: self.token) else {
            return false
        }
        if savedToken != token {
            return false
        }
        return true
    }
    
    static func fetch() -> String {
        return defaults.string(forKey: token)!
    }
    
    static func update(token: String) {
        defaults.setValue(token, forKey: self.token)
        defaults.setValue(false, forKey: self.sent)
    }
    
    static func update(sent: Bool) {
        defaults.setValue(true, forKey: self.sent)
    }
    
    static func wasSent() -> Bool {
        return defaults.bool(forKey: sent)
    }
}
