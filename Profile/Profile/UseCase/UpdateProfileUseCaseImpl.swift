//
//  UpdateProfileUseCaseImpl.swift
//  Profile
//
//  Created by Matheus Valbert on 06/09/23.
//

import Foundation
import DataComponents

final class UpdateProfileUseCaseImpl: UpdateProfileUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(username: String, language: Languages) async throws {
        try await userRepository.update(username: username, language: language)
    }
}
