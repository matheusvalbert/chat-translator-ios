//
//  FetchChatsUseCaseImpl.swift
//  Chats
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation
import DataComponents

final class FetchChatsUseCaseImpl: FetchChatsUseCase {
    
    private let friendRepository: FriendRepository
    private let chatRepository: ChatRepository
    
    init(friendRepository: FriendRepository, chatRepository: ChatRepository) {
        self.friendRepository = friendRepository
        self.chatRepository = chatRepository
    }
    
    func execute() async throws -> (friends: [FriendDomain], chats: [ChatDomain]) {
        
        return (friends: try await friendRepository.fetchAccepted(), chats: try await chatRepository.fetch())
    }
}
