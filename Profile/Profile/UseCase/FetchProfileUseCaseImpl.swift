//
//  FetchProfileUseCaseImpl.swift
//  Profile
//
//  Created by Matheus Valbert on 01/09/23.
//

import Foundation
import DataComponents

final class FetchProfileUseCaseImpl: FetchProfileUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> UserDomain {
        return try await userRepository.fetch()
    }
}
