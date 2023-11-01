//
//  TabBarCoordinator.swift
//  DataComponents
//
//  Created by Matheus Valbert on 31/10/23.
//

import Foundation

public enum TabBarType: Int {
    case friends = 0
    case chats = 1
    case profile = 2
    
}

public protocol ExposedCoordinator {
    func updateBarBadge(type: TabBarType, value: String?)
    func fetchFriendsFromNotification()
    func navigateToChatMessagesFromNotification(username: String, tag: Int64) async throws
    func navigateToFriendRequestFromNotification(tag: Int64) async throws
    func navigateToFriendsFromNotification()
}
