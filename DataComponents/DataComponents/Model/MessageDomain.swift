//
//  MessageDomain.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation

public struct MessageDomain: Codable {
    public var id: UUID
    public var tag: Int64
    public var message: String
    public var date: Date?
    public var translatedMessage: String?
    public var senderOrReceiver: SenderOrReceiver
    public var status: MessageStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case tag
        case message
        case date
        case translatedMessage
        case senderOrReceiver
        case status
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        tag = try container.decode(Int64.self, forKey: .tag)
        message = try container.decode(String.self, forKey: .message)
        date = try container.decode(Date.self, forKey: .date)
        translatedMessage = try container.decode(String.self, forKey: .translatedMessage)
        senderOrReceiver = SenderOrReceiver(rawValue: try container.decode(String.self, forKey: .senderOrReceiver))!
        status = MessageStatus(rawValue: try container.decode(String.self, forKey: .status))!
    }
    
    public init(id: UUID, tag: Int64, message: String, date: Date? = nil, translatedMessage: String? = nil, senderOrReceiver: SenderOrReceiver, status: MessageStatus) {
        self.id = id
        self.tag = tag
        self.message = message
        self.date = date
        self.translatedMessage = translatedMessage
        self.senderOrReceiver = senderOrReceiver
        self.status = status
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(tag, forKey: .tag)
        try container.encode(message, forKey: .message)
        try container.encode(date, forKey: .date)
        try container.encode(translatedMessage, forKey: .translatedMessage)
        try container.encode(senderOrReceiver.rawValue, forKey: .senderOrReceiver)
        try container.encode(status.rawValue, forKey: .status)
    }
    
    static func listResponseToMessageEntity(list: [ReceiveResponse]) -> [MessageDomain] {
        
        return list.map { item in
            return MessageDomain(id: item.id, tag: item.sender.tag, message: item.message, date: item.timestamp, translatedMessage: item.translatedMessage, senderOrReceiver: .receiver, status: .completed)
        }
    }
    
    static func getIds(list: [MessageDomain]) -> [String] {
        return list.map { $0.id.uuidString.lowercased() }
    }
}
