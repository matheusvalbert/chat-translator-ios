//
//  ResponseFriendRequestUseCaseImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 24/10/23.
//

import Foundation

final class ResponseFriendRequestUseCaseImpl: ResponseFriendRequestUseCase {
    
    private let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
 
    func execute(tag: Int64, status: FriendStatus) async throws {
        try await friendRepository.response(tag: tag, status: status)
    }
}
