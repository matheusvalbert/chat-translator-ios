//
//  UpdateMessagesUseCaseImpl.swift
//  Chats
//
//  Created by Matheus Valbert on 03/10/23.
//

import Foundation
import DataComponents

final class UpdateMessagesUseCaseImpl: UpdateMessagesUseCase {
    
    func execute(oldMessages: [MessageDomain], newMessage: MessageDomain) -> [MessageDomain] {
        var messages = oldMessages
        
        if let index = messages.firstIndex(where: { $0.id == newMessage.id }) {
            messages[index] = newMessage
        } else {
            messages.append(newMessage)
        }
        
        return messages
    }
}
