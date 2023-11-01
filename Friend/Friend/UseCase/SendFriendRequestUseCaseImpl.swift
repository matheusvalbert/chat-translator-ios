//
//  SendFriendRequestUseCaseImpl.swift
//  Friend
//
//  Created by Matheus Valbert on 13/09/23.
//

import Foundation
import DataComponents

final class SendFriendRequestUseCaseImpl: SendFriendRequestUseCase {
    
    private let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func execute(user: String) async throws {
        let result = try extractUsernameAndTag(user: user)
        try await friendRepository.request(username: result.username, tag: result.tag)
    }
    
    private func extractUsernameAndTag(user: String) throws -> (username: String, tag: Int64) {
        let result = user.split(separator: "#")
        guard result.count == 2,
              let username = result.first.map(String.init),
              let tag = Int64(result.last!)
        else { throw InputError.invalidUser }
        
        if !username.isValidUsername() || tag <= 0 {
            throw InputError.invalidUser
        }
        
        return (username, tag)
    }
}
