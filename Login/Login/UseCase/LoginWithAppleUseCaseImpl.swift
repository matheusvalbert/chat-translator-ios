//
//  LoginWithAppleUseCaseImpl.swift
//  Login
//
//  Created by Matheus Valbert on 04/11/23.
//

import Foundation
import DataComponents

final class LoginWithAppleUseCaseImpl : LoginWithAppleUseCase {
    
    private let firebaseRepository: FirebaseRepository
    private let userRepository: UserRepository
    private let friendRepository: FriendRepository
    
    required init(firebaseRepository: FirebaseRepository, userRepository: UserRepository, friendRepository: FriendRepository) {
        self.firebaseRepository = firebaseRepository
        self.userRepository = userRepository
        self.friendRepository = friendRepository
    }
    
    func execute() async throws {
        let auth = try await firebaseRepository.loginWithApple()
        let token = try await firebaseRepository.fetchToken(auth: auth)
        let user = try await userRepository.login(token: token)
        try await userRepository.insert(username: user.username, tag: user.tag, language: user.language)
        Token.insert(token: user.token!, refresherToken: user.refresherToken!)
        try await friendRepository.reloadFriendData()
        try await userRepository.updateToken()
    }
}
