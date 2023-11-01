//
//  FetchMessagesUseCaseImpl.swift
//  Chats
//
//  Created by Matheus Valbert on 02/10/23.
//

import Foundation
import DataComponents

final class FetchMessagesUseCaseImpl: FetchMessagesUseCase {
    
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(tag: Int64) async throws -> [MessageDomain] {
        return try await messageRepository.fetch(tag: tag)
    }
}
