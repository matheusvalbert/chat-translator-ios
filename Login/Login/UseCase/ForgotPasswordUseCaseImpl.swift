//
//  ForgotPasswordUseCaseImpl.swift
//  Login
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation
import DataComponents

final class ForgotPasswordUseCaseImpl: ForgotPasswordUseCase {
    
    private let firebaseRepository: FirebaseRepository
    
    init(firebaseRepository: FirebaseRepository) {
        self.firebaseRepository = firebaseRepository
    }
    
    func execute(email: String) async throws {
        try validate(email: email)
        try await firebaseRepository.forgotPassword(email: email)
    }
    
    private func validate(email: String) throws {
        if !email.isValidEmail() {
            throw InputError.invalidEmail
        }
    }
}
