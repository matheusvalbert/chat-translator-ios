//
//  UpdateChatsUseCaseImpl.swift
//  Chats
//
//  Created by Matheus Valbert on 25/10/23.
//

import Foundation
import DataComponents

final class UpdateChatsUseCaseImpl: UpdateChatsUseCase {
    
    func execute(oldChats: [ChatDomain], newChat: ChatDomain) -> [ChatDomain] {
        var chats = oldChats
        
        if let index = chats.firstIndex(where: { $0.tag == newChat.tag }) {
            chats[index] = newChat
        } else {
            chats.append(newChat)
        }
        
        return chats
    }
}
