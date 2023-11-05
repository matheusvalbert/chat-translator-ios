//
//  FirebaseRepositoryImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 25/08/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices

class FirebaseRepositoryImpl: NSObject, FirebaseRepository {
    
    private var appleSignInCompletion: CheckedContinuation<ASAuthorizationAppleIDCredential, Error>?
    private let presentationProvider = AppleSignInPresentationProvider()
    
    func configureId() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    func signUp(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func forgotPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func loginWithGoogle() async throws -> AuthDataResult {
        let result = try await signInWithGoogle()
        let user = result.user
        
        guard let idToken = user.idToken?.tokenString else { throw FirebaseError.loginWithGoogleCredentialError }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
        return try await Auth.auth().signIn(with: credential)
    }
    
    @MainActor
    private func signInWithGoogle() async throws -> GIDSignInResult {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { throw FirebaseError.recoveryUIViewControllerError }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { throw FirebaseError.recoveryUIViewControllerError }
        return try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
    }
    
    func loginWithApple() async throws -> AuthDataResult {
        let nonce = String().randomNonceString()
        let result = try await signInWithApple(nonce: nonce.sha256())
        let credential = OAuthProvider.appleCredential(withIDToken: String(data: result.identityToken!, encoding: .utf8)!, rawNonce: nonce, fullName: result.fullName)
        return try await Auth.auth().signIn(with: credential)
    }
    
    private func signInWithApple(nonce: String) async throws -> ASAuthorizationAppleIDCredential {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = presentationProvider

        do {
            let credential = try await withCheckedThrowingContinuation { continuation in
                self.appleSignInCompletion = continuation
                authorizationController.performRequests()
            }
            return credential
        } catch {
            throw error
        }
    }
    
    func fetchToken(auth: AuthDataResult) async throws -> String {
        return try await auth.user.getIDTokenResult().token
    }
    
    func deleteAccount() async throws {
        try await Auth.auth().currentUser?.delete()
    }
}

extension FirebaseRepositoryImpl: ASAuthorizationControllerDelegate {
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
