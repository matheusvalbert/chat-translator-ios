//
//  FriendRequest.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import UIKit
import UserNotifications

final class FriendMessage {
    private let friendRepository: FriendRepository
    private let chatRepository: ChatRepository
    private let reloadFriendsListUseCase: ReloadFriendsListUseCase
    private let responseFriendRequestUseCase: ResponseFriendRequestUseCase
    private let exposedCoordinator: ExposedCoordinator
    
    init(friendRepository: FriendRepository, chatRepository: ChatRepository, reloadFriendsListUseCase: ReloadFriendsListUseCase, responseFriendRequestUseCase: ResponseFriendRequestUseCase, exposedCoordinator: ExposedCoordinator) {
        self.friendRepository = friendRepository
        self.chatRepository = chatRepository
        self.reloadFriendsListUseCase = reloadFriendsListUseCase
        self.responseFriendRequestUseCase = responseFriendRequestUseCase
        self.exposedCoordinator = exposedCoordinator
    }
    
    func requested(message: MessageReceived) async throws {
        
        let acceptAction = UNNotificationAction(identifier: "ACCEPTED_ACTION", title: "Accept", options: [.authenticationRequired])
        let declineAction = UNNotificationAction(identifier: "DECLINED_ACTION", title: "Decline", options: [.authenticationRequired])
        
        let category = UNNotificationCategory(
            identifier: "REQUEST_CATEGORY",
            actions: [acceptAction, declineAction],
            intentIdentifiers: [],
            options: []
        )
        
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = "Friend request"
        content.body = "New friend request from \(message.username)#\(message.tag)"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "REQUEST_CATEGORY"
        
        let request = UNNotificationRequest(identifier: message.username + "#" + String(message.tag) + "&" + "requested" + "&" + UUID().uuidString, content: content, trigger: nil)
        
        try await UNUserNotificationCenter.current().add(request)
        
        try await reloadFriendsListUseCase.execute()
        
        exposedCoordinator.fetchFriendsFromNotification()
        
        let waitingFriends = try await friendRepository.count(byStatus: .waiting)
        let unreadMessages = try await chatRepository.getUnreadMessagesCount()
        
        DispatchQueue.main.async {
            self.exposedCoordinator.updateBarBadge(type: .friends, value: waitingFriends != 0 ? String(waitingFriends) : nil)
            UIApplication.shared.applicationIconBadgeNumber = waitingFriends + unreadMessages
        }
    }
    
    func responsed(message: MessageReceived) async throws {
        
        let content = UNMutableNotificationContent()
        content.title = "Friend request accepted"
        content.body = "New friend request accepted from \(message.username)#\(message.tag)"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "RESPONSE_CATEGORY"
        
        let request = UNNotificationRequest(identifier: message.username + "#" + String(message.tag) + "&" + "responsed" + "&" + UUID().uuidString, content: content, trigger: nil)
        
        try await UNUserNotificationCenter.current().add(request)
        
        try await reloadFriendsListUseCase.execute()
        
        exposedCoordinator.fetchFriendsFromNotification()
        
        let waitingFriends = try await friendRepository.count(byStatus: .waiting)
        let unreadMessages = try await chatRepository.getUnreadMessagesCount()
        
        DispatchQueue.main.async {
            self.exposedCoordinator.updateBarBadge(type: .friends, value: waitingFriends != 0 ? String(waitingFriends) : nil)
            UIApplication.shared.applicationIconBadgeNumber = waitingFriends + unreadMessages
        }
    }
    
    func reply(message: MessageReplyed, response: FriendStatus) async throws {
        
        try await responseFriendRequestUseCase.execute(tag: message.tag, status: response)
        try await reloadFriendsListUseCase.execute()
    }
    
    func navigateToRequest(message: MessageReplyed) async throws {
        try await exposedCoordinator.navigateToFriendRequestFromNotification(tag: message.tag)
    }
    
    func navigateToFriends() {
        exposedCoordinator.navigateToFriendsFromNotification()
    }
}
