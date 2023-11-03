//
//  ChatRepositoryImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation

final class ChatRepositoryImpl: ChatRepository {
    
    private let chatDao: ChatDao
    private let chatEventBus: ChatEventBus
    
    init(chatDao: ChatDao, chatEventBus: ChatEventBus) {
        self.chatDao = chatDao
        self.chatEventBus = chatEventBus
    }
    
    func insert(tag: Int64, message: String, incrementUnreadMessages: Bool) async throws {
        try await chatDao.insert(tag: tag, lastMessage: message, incrementUnreadMessages: incrementUnreadMessages)
        chatEventBus.event.send(ChatDomain(tag: tag, lastMessage: message, unreadMessages: 1))
    }
    
    func update(tag: Int64, message: String, incrementUnreadMessages: Bool) async throws {
        let unreadMessages = try await chatDao.update(tag: tag, message: message, incrementUnreadMessages: incrementUnreadMessages)
        chatEventBus.event.send(ChatDomain(tag: tag, lastMessage: message, unreadMessages: unreadMessages))
    }
    
    func fetch() async throws -> [ChatDomain] {
        return try await chatDao.fetch().map { chat in
            return ChatDomain(tag: chat.tag, lastMessage: chat.lastMessage, unreadMessages: chat.unreadMessages)
        }
    }
    
    func exists(tag: Int64) async throws -> Bool {
        return try await chatDao.exists(tag: tag)
    }
    
    func removeUnreadMessages(tag: Int64) async throws {
        try await chatDao.removeUnreadMessages(tag: tag)
    }
    
    func remove(tag: Int64) async throws {
        try await chatDao.remove(byTag: tag)
    }
    
    func getUnreadMessagesCount() async throws -> Int {
        return Int(try await chatDao.fetch().reduce(0) { $0 + $1.unreadMessages })
    }
    
    func delete() async throws {
        try await chatDao.delete()
    }
}
