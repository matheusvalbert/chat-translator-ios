//
//  LoginViewModelImpl.swift
//  Login
//
//  Created by Matheus Valbert on 28/08/23.
//

import Foundation
import DataComponents

public final class LoginViewModel {
    
    private let configureGoogleIdUseCase: ConfigureGoogleIdUseCase
    private let loginWithGoogleUseCase: LoginWithGoogleUseCase
    private let loginWithAppleUseCase: LoginWithAppleUseCase
    private let signUpUseCase: SignUpUseCase
    private let signInUseCase: SignInUseCase
    private let forgotPasswordUseCase: ForgotPasswordUseCase
    
    required init(configureGoogleIdUseCase: ConfigureGoogleIdUseCase, loginWithGoogleUseCase: LoginWithGoogleUseCase, loginWithAppleUseCase: LoginWithAppleUseCase, signUpUseCase: SignUpUseCase, signInUseCase: SignInUseCase, forgotPasswordUseCase: ForgotPasswordUseCase) {
        self.configureGoogleIdUseCase = configureGoogleIdUseCase
        self.loginWithGoogleUseCase = loginWithGoogleUseCase
        self.loginWithAppleUseCase = loginWithAppleUseCase
        self.signUpUseCase = signUpUseCase
        self.signInUseCase = signInUseCase
        self.forgotPasswordUseCase = forgotPasswordUseCase
    }
    
    func configureId() {
        configureGoogleIdUseCase.execute()
    }
    
    func loginWithGoogle() async throws {
        try await loginWithGoogleUseCase.execute()
    }
    
    func loginWithApple() async throws {
        try await loginWithAppleUseCase.execute()
    }
    
    func signUp(username: String, email: String, password: String) async -> Bool {
        do {
            try await signUpUseCase.execute(username: username, email: email, password: password)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func signIn(email: String, password: String) async throws {
        try await signInUseCase.execute(email: email, password: password)
    }
    
    func forgotPassword(email: String) async throws {
        try await forgotPasswordUseCase.execute(email: email)
    }
}
