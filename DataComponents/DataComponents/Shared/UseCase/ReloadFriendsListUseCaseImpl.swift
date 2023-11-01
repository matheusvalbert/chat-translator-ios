//
//  ReloadFriendsListUseCaseImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 24/10/23.
//

import UIKit

final class ReloadFriendsListUseCaseImpl: ReloadFriendsListUseCase {
    
    private let friendRepository: FriendRepository
    private let chatRepository: ChatRepository
    private let exposedCoordinator: ExposedCoordinator
    
    init(friendRepository: FriendRepository, chatRepository: ChatRepository, exposedCoordinator: ExposedCoordinator) {
        self.friendRepository = friendRepository
        self.chatRepository = chatRepository
        self.exposedCoordinator = exposedCoordinator
    }
    
    func execute() async throws {
        try await friendRepository.reloadFriendData()
        
        let waitingFriends = try await friendRepository.count(byStatus: .waiting)
        let unreadMessages = try await chatRepository.getUnreadMessagesCount()
        
        DispatchQueue.main.async {
            self.exposedCoordinator.updateBarBadge(type: .friends, value: waitingFriends != 0 ? String(waitingFriends) : nil)
            UIApplication.shared.applicationIconBadgeNumber = waitingFriends + unreadMessages
        }
    }
}
