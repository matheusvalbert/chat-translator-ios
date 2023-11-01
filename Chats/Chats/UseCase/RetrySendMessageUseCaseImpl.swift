//
//  RetrySendMessageUseCaseImpl.swift
//  Chats
//
//  Created by Matheus Valbert on 04/10/23.
//

import Foundation
import DataComponents

final class RetrySendMessageUseCaseImpl: RetrySendMessageUseCase {
    
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(id: UUID) async throws {
        try await messageRepository.retrySend(id: id)
    }
}
