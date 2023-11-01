//
//  FetchUserProfileFromServerUseCaseImpl.swift
//  Profile
//
//  Created by Matheus Valbert on 08/09/23.
//

import Foundation
import DataComponents

final class FetchUserProfileFromServerUseCaseImpl: FetchUserProfileFromServerUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> UserDomain {
        try await userRepository.reloadUserData()
        return try await userRepository.fetch()
    }
}
