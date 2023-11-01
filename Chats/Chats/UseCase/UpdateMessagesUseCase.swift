//
//  UpdateMessagesUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 03/10/23.
//

import Foundation
import DataComponents

protocol UpdateMessagesUseCase {

    func execute(oldMessages: [MessageDomain], newMessage: MessageDomain) -> [MessageDomain]
}
