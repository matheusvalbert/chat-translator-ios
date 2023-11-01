//
//  FirebaseRepository.swift
//  DataComponents
//
//  Created by Matheus Valbert on 25/08/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

public protocol FirebaseRepository {
    
    func configureId()
    
    func signUp(email: String, password: String) async throws -> AuthDataResult
    
    func signIn(email: String, password: String) async throws -> AuthDataResult
    
    func forgotPassword(email: String) async throws
    
    func loginWithGoogle() async throws -> AuthDataResult
    
    func fetchToken(auth: AuthDataResult) async throws -> String
    
    func sendMessageToken()
}
