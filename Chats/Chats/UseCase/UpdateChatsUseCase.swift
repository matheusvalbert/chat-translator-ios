//
//  UpdateChatsUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 25/10/23.
//

import Foundation
import DataComponents

protocol UpdateChatsUseCase {

    func execute(oldChats: [ChatDomain], newChat: ChatDomain) -> [ChatDomain]
}
