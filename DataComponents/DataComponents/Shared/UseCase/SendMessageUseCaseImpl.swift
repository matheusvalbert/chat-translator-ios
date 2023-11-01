//
//  SendMessageUseCaseImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 24/10/23.
//

import Foundation

final class SendMessageUseCaseImpl: SendMessageUseCase {
    
    private let chatRepository: ChatRepository
    private let messageRepository: MessageRepository
    
    init(chatRepository: ChatRepository, messageRepository: MessageRepository) {
        self.chatRepository = chatRepository
        self.messageRepository = messageRepository
    }
    
    func execute(tag: Int64, message: String) async throws {
        try await messageRepository.send(tag: tag, message: message)
        if (try await !chatRepository.exists(tag: tag)) {
            try await chatRepository.insert(tag: tag, message: message, incrementUnreadMessages: false)
        } else {
            try await chatRepository.update(tag: tag, message: message, incrementUnreadMessages: false)
        }
    }
}
