//
//  RemoveUnreadMessagesUseCaseImpl.swift
//  Chats
//
//  Created by Matheus Valbert on 11/10/23.
//

import Foundation
import DataComponents

final class RemoveUnreadMessagesUseCaseImpl: RemoveUnreadMessagesUseCase {
    
    private let chatRepository: ChatRepository
    
    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func execute(tag: Int64) async throws {
        if try await chatRepository.exists(tag: tag) {
            try await chatRepository.removeUnreadMessages(tag: tag)
        }
    }
}
