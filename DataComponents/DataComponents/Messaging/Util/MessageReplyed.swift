//
//  MessageReplyed.swift
//  DataComponents
//
//  Created by Matheus Valbert on 24/10/23.
//

import Foundation
import UserNotifications

struct MessageReplyed: Decodable {
    let category: MessageCategory
    let action: MessageReplyType?
    let username: String
    let tag: Int64
    let message: String?
    
    enum CodingKeys: CodingKey {
        case category
        case action
        case username
        case tag
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category = try MessageCategory(rawValue: container.decode(String.self, forKey: .category))!
        self.action = try MessageReplyType(rawValue: container.decode(String.self, forKey: .action))!
        self.username = try container.decode(String.self, forKey: .username)
        self.tag = try container.decode(Int64.self, forKey: .tag)
        self.message = try container.decode(String.self, forKey: .message)
    }
    
    init(from message: UNNotificationResponse) {
        self.category = MessageCategory(rawValue: message.notification.request.content.categoryIdentifier)!
        self.action = MessageReplyType(rawValue: message.actionIdentifier)
        let identifier = message.notification.request.identifier
        let usernameParts = identifier.components(separatedBy: "#")
        self.username = usernameParts[0]
        let tagParts = usernameParts[1].components(separatedBy: "&")
        self.tag = Int64(tagParts[0])!
        let textResponse = message as? UNTextInputNotificationResponse
        self.message = textResponse?.userText
    }
}
