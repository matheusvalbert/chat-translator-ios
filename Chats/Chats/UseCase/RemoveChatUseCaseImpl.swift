//
//  RemoveChatUseCaseImpl.swift
//  Chats
//
//  Created by Matheus Valbert on 11/10/23.
//

import UIKit
import DataComponents

final class RemoveChatUseCaseImpl: RemoveChatUseCase {
    
    private let friendRepository: FriendRepository
    private let chatRepository: ChatRepository
    private let messageRepository: MessageRepository
    
    init(friendRepository: FriendRepository, chatRepository: ChatRepository, messageRepository: MessageRepository) {
        self.friendRepository = friendRepository
        self.chatRepository = chatRepository
        self.messageRepository = messageRepository
    }
    
    func execute(tag: Int64) async throws {
        try await messageRepository.remove(tag: tag)
        try await chatRepository.remove(tag: tag)
        
        let waitingFriends = try await friendRepository.count(byStatus: .waiting)
        let unreadMessages = try await chatRepository.getUnreadMessagesCount()
        
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = waitingFriends + unreadMessages
        }
    }
}
