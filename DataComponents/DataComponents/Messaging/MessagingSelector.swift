//
//  MessagingSelector.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import Foundation
import NotificationCenter

public final class MessagingSelector {
    
    let friendMessage: FriendMessage
    let messageMessage: MessageMessage
    
    init(friendMessage: FriendMessage, messageMessage: MessageMessage) {
        self.friendMessage = friendMessage
        self.messageMessage = messageMessage
    }
    
    public func received(message: [AnyHashable: Any]) async throws {
        let message = MessageReceived.init(from: message)
        try await generateNotification(message: message)
    }
    
    private func generateNotification(message: MessageReceived) async throws {
        switch message.type {
        case .friendRequest:
            try await friendMessage.requested(message: message)
        case .friendResponse:
            try await friendMessage.responsed(message: message)
        case .receiveMessage:
            try await messageMessage.response(message: message)
        }
    }
    
    public func replyed(message: UNNotificationResponse) async throws {
        let message = MessageReplyed.init(from: message)
        try await generateResponse(message: message)
    }
    
    private func generateResponse(message: MessageReplyed) async throws {
        switch message.action {
        case .requestAccepted:
            try await friendMessage.reply(message: message, response: .accepted)
        case .requestDeclined:
            try await friendMessage.reply(message: message, response: .declined)
        case .reply:
            try await messageMessage.reply(message: message)
        case .none:
            try await tapped(message: message)
        }
    }
    
    private func tapped(message: MessageReplyed) async throws {
        switch message.category {
        case .request:
            try await friendMessage.navigateToRequest(message: message)
        case .response:
            friendMessage.navigateToFriends()
        case .reply:
            try await messageMessage.navigate(message: message)
        }
    }
}
