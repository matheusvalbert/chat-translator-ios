//
//  String+Ext.swift
//  DataComponents
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation
import CryptoKit

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
    
    func randomNonceString(length: Int = 32) -> Self {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    func sha256() -> String {
      let inputData = Data(self.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}
