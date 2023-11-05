//
//  AppleSignInAuthorizationControllerDelegate.swift
//  DataComponents
//
//  Created by Matheus Valbert on 05/11/23.
//

import Foundation
import AuthenticationServices

class AppleSignInAuthorizationControllerDelegate: NSObject, ASAuthorizationControllerDelegate {
    var appleSignInCompletion: CheckedContinuation<ASAuthorizationAppleIDCredential, Error>?
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            appleSignInCompletion?.resume(returning: appleIDCredential)
            appleSignInCompletion = nil
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleSignInCompletion?.resume(throwing: error)
        appleSignInCompletion = nil
    }
}
