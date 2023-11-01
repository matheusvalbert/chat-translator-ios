//
//  SignInUseCaseImpl.swift
//  Login
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation
import DataComponents

final class SignInUseCaseImpl: SignInUseCase {
    
    private let firebaseRepository: FirebaseRepository
    private let userRepository: UserRepository
    private let friendRepository: FriendRepository
    
    init(firebaseRepository: FirebaseRepository, userRepository: UserRepository, friendRepository: FriendRepository) {
        self.firebaseRepository = firebaseRepository
        self.userRepository = userRepository
        self.friendRepository = friendRepository
    }
    
    func execute(email: String, password: String) async throws {
        try validate(email: email, password: password)
        let auth = try await firebaseRepository.signIn(email: email, password: password)
        let token = try await firebaseRepository.fetchToken(auth: auth)
        let user = try await userRepository.login(token: token)
        try await userRepository.insert(username: user.username, tag: user.tag, language: user.language)
        Token.insert(token: user.token!, refresherToken: user.refresherToken!)
        try await friendRepository.reloadFriendData()
        try await userRepository.updateToken()
    }
    
    private func validate(email: String, password: String) throws {
        if !email.isValidEmail() {
            throw InputError.invalidEmail
        } else if !password.isValidPassword() {
            throw InputError.invalidPassword
        }
    }
}
