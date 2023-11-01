//
//  SendFirebaseTokenUseCaseImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import Foundation

final class SendFirebaseTokenUseCaseImpl: SendFirebaseTokenUseCase {
    
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(token: String) async throws {
        userRepository.insert(token: token)
        if try await userRepository.exits() {
            try await userRepository.updateToken()
        }
    }
    
}
