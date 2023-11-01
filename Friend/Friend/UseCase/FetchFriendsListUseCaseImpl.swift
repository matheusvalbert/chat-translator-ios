//
//  FetchFriendsListUseCaseImpl.swift
//  Friend
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation
import DataComponents

final class FetchFriendsListUseCaseImpl: FetchFriendsListUseCase {
    
    private let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func execute() async throws -> [FriendDomain] {
        return try await friendRepository.fetch()
    }
}
