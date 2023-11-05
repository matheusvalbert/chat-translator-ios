//
//  a.swift
//  DataComponents
//
//  Created by Matheus Valbert on 04/11/23.
//

import Foundation
import AuthenticationServices

class AppleSignInPresentationProvider: NSObject, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) {
            return windowScene.windows.first!
        } else {
            fatalError("Unable to find a valid window scene.")
        }
    }
}
