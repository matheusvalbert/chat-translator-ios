//
//  aaa.swift
//  Chats
//
//  Created by Matheus Valbert on 12/10/23.
//

import UIKit
import DataComponents

final class ResetUnreadMessagesCounterUseCaseImpl: ResetUnreadMessagesCounterUseCase {
    
    private let friendRepository: FriendRepository
    private let chatRepository: ChatRepository
    private let exposedCoordinator: ExposedCoordinator
    
    init(friendRepository: FriendRepository, chatRepository: ChatRepository, exposedCoordinator: ExposedCoordinator) {
        self.friendRepository = friendRepository
        self.chatRepository = chatRepository
        self.exposedCoordinator = exposedCoordinator
    }
    
    func execute(tag: Int64) async throws {

        if try await chatRepository.exists(tag: tag) {
            try await chatRepository.removeUnreadMessages(tag: tag)
        }
        
        let waitingFriends = try await friendRepository.count(byStatus: .waiting)
        let unreadMessages = try await chatRepository.getUnreadMessagesCount()
        
        DispatchQueue.main.async {
            self.exposedCoordinator.updateBarBadge(type: .chats, value: unreadMessages != 0 ? String(unreadMessages) : nil)
            UIApplication.shared.applicationIconBadgeNumber = waitingFriends + unreadMessages
        }
    }
}
