//
//  ReceiveMessagesUseCaseImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 09/10/23.
//

import UIKit

final class ReceiveMessagesUseCaseImpl: ReceiveMessagesUseCase {
    
    private let friendRepository: FriendRepository
    private let chatRepository: ChatRepository
    private let messageRepository: MessageRepository
    private let exposedCoordinator: ExposedCoordinator
    
    init(friendRepository: FriendRepository, chatRepository: ChatRepository, messageRepository: MessageRepository, exposedCoordinator: ExposedCoordinator) {
        self.friendRepository = friendRepository
        self.chatRepository = chatRepository
        self.messageRepository = messageRepository
        self.exposedCoordinator = exposedCoordinator
    }
    
    func execute() async throws {
        for message in try await messageRepository.receive().sorted(by: { $0.date! < $1.date! }) {
            if try await !friendRepository.exists(byTag: message.tag) {
                try await friendRepository.reloadFriendData()
            }
            if try await chatRepository.exists(tag: message.tag) {
                try await chatRepository.update(tag: message.tag, message: message.translatedMessage ?? message.message, incrementUnreadMessages: true)
            } else {
                try await chatRepository.insert(tag: message.tag, message: message.translatedMessage ?? message.message, incrementUnreadMessages: true)
            }
            
            let waitingFriends = try await friendRepository.count(byStatus: .waiting)
            let unreadMessages = try await chatRepository.getUnreadMessagesCount()
            
            DispatchQueue.main.async {
                self.exposedCoordinator.updateBarBadge(type: .chats, value: unreadMessages != 0 ? String(unreadMessages) : nil)
                UIApplication.shared.applicationIconBadgeNumber = waitingFriends + unreadMessages
            }
        }
    }
}
