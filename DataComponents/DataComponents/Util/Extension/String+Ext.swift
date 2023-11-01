//
//  String+Ext.swift
//  DataComponents
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation

public extension String {
    
    private func lessThanOrEqualToThirtyCharacters() -> Bool {
        return self.count < 31
    }
    
    private func onlyLettersAndWhitespace() -> Bool {
        return self.allSatisfy { $0.isLetter || $0.isWhitespace }
    }
    
    private func mailPattern() -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    private func moreThanOrEqualToEightCharacters() -> Bool {
        return self.count > 7
    }
    
    func isValidUsername() -> Bool {
        return !self.isEmpty && self.lessThanOrEqualToThirtyCharacters() && self.onlyLettersAndWhitespace()
    }
    
    func isValidEmail() -> Bool {
        return !self.isEmpty && self.mailPattern()
    }
    
    func isValidPassword() -> Bool {
        return self.moreThanOrEqualToEightCharacters()
    }
}
