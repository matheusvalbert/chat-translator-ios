//
//  MessageRepositoryImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation

final class MessageRepositoryImpl: MessageRepository {
    
    private let messageService: MessageService
    private let messageDao: MessageDao
    private let messageEventBus: MessageEventBus
    
    init(messageService: MessageService, messageDao: MessageDao, messageEventBus: MessageEventBus) {
        self.messageService = messageService
        self.messageDao = messageDao
        self.messageEventBus = messageEventBus
    }
    
    func send(tag: Int64, message: String) async throws {
        
        let id = UUID()
        
        messageEventBus.event.send(MessageDomain(id: id, tag: tag, message: message, senderOrReceiver: .sender, status: .pending))
        
        do {
            let response = try await messageService.send(data: SendRequest(tag: tag, message: message))
            try await messageDao.insert(id: id, tag: tag, message: message, date: response.date, translatedMessage: "", senderOrReceiver: .sender, status: .completed)
            messageEventBus.event.send(MessageDomain(id: id, tag: tag, message: message, date: response.date, senderOrReceiver: .sender, status: .completed))
        } catch {
            print(error)
            try await messageDao.insert(id: id, tag: tag, message: message, date: Date(), translatedMessage: "", senderOrReceiver: .sender, status: .error)
            messageEventBus.event.send(MessageDomain(id: id, tag: tag, message: message, date: Date(), senderOrReceiver: .sender, status: .error))
        }
    }
    
    func retrySend(id: UUID) async throws {
        let message = try await messageDao.fetch(byId: id)
        let response = try await messageService.send(data: SendRequest(tag: message.tag, message: message.message))
        try await messageDao.update(id: message.id, date: response.date, status: .completed)
        messageEventBus.event.send(MessageDomain(id: id, tag: message.tag, message: message.message, date: response.date, senderOrReceiver: .sender, status: .completed))
    }
    
    func receive() async throws -> [MessageDomain] {
        guard let messages = try await messageService.receive().messages else {
            return []
        }
        
        let data = MessageDomain.listResponseToMessageEntity(list: messages)
        
        for message in data {
            messageEventBus.event.send(message)
        }
        
        try await messageDao.insert(messages: data.encodeToEntity())
        
        for id in MessageDomain.getIds(list: data) {
            try await messageService.delete(data: ConfirmRequest(messageId: id))
        }
        
        return data
    }
    
    func fetch(tag: Int64) async throws -> [MessageDomain] {
        return try await messageDao.fetch(byTag: tag).map { message in
            return MessageDomain(id: message.id, tag: message.tag, message: message.message, date: message.date, translatedMessage: message.translatedMessage, senderOrReceiver: SenderOrReceiver(rawValue: message.senderOrReceiver)!, status: MessageStatus(rawValue: message.status)!)
        }
    }
    
    func remove(tag: Int64) async throws {
        try await messageDao.remove(byTag: tag)
    }
    
    func delete() async throws {
        try await messageDao.delete()
    }
}
