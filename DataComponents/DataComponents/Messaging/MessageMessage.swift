//
//  MessageMessage.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import Foundation
import UserNotifications

final class MessageMessage {
    
    private let receiveMessagesUseCase: ReceiveMessagesUseCase
    private let sendMessageUseCase: SendMessageUseCase
    private let exposedCoordinator: ExposedCoordinator
    
    init(receiveMessagesUseCase: ReceiveMessagesUseCase, sendMessageUseCase: SendMessageUseCase, exposedCoordinator: ExposedCoordinator) {
        self.receiveMessagesUseCase = receiveMessagesUseCase
        self.sendMessageUseCase = sendMessageUseCase
        self.exposedCoordinator = exposedCoordinator
    }
    
    func response(message: MessageReceived) async throws {
        
        let replyAction = UNTextInputNotificationAction(
            identifier: "REPLY_ACTION",
            title: "Reply",
            options: [.authenticationRequired],
            textInputButtonTitle: "Send",
            textInputPlaceholder: "Type your reply"
        )
        
        let category = UNNotificationCategory(
            identifier: "REPLY_CATEGORY",
            actions: [replyAction],
            intentIdentifiers: [],
            options: []
        )
        
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = message.username + "#" + String(message.tag)
        content.body = message.message
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "REPLY_CATEGORY"
        
        let request = UNNotificationRequest(identifier: message.username + "#" + String(message.tag) + "&" + "message" + "&" + UUID().uuidString, content: content, trigger: nil)
        
        try await UNUserNotificationCenter.current().add(request)
        
        try await receiveMessagesUseCase.execute()
    }
    
    func reply(message: MessageReplyed) async throws {
        guard let response = message.message else { return }
        try await sendMessageUseCase.execute(tag: message.tag, message: response)
    }
    
    func navigate(message: MessageReplyed) async throws {
        try await exposedCoordinator.navigateToChatMessagesFromNotification(username: message.username, tag: message.tag)
    }
}
