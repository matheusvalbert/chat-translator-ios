//
//  Token.swift
//  DataComponents
//
//  Created by Matheus Valbert on 01/09/23.
//

import Foundation

public enum Token {
    
    private static let token = "TOKEN"
    private static let refresherToken = "REFRESHER_TOKEN"
    private static let defaults = UserDefaults.standard
    
    public static func insert(token: String, refresherToken: String) {
        defaults.setValue(token, forKey: self.token)
        defaults.setValue(refresherToken, forKey: self.refresherToken)
    }
    
    public static func fetchToken() -> String {
        return defaults.string(forKey: token)!
    }
    
    public static func fetchRefresherToken() -> String {
        return defaults.string(forKey: refresherToken)!
    }
}
