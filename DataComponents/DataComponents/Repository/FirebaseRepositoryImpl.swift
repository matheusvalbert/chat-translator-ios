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

class FirebaseRepositoryImpl: FirebaseRepository {
    
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
    func signInWithGoogle() async throws -> GIDSignInResult {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { throw FirebaseError.recoveryUIViewControllerError }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { throw FirebaseError.recoveryUIViewControllerError }
        return try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
    }
    
    func fetchToken(auth: AuthDataResult) async throws -> String {
        return try await auth.user.getIDTokenResult().token
    }
    
    func sendMessageToken() {
        
    }
}
