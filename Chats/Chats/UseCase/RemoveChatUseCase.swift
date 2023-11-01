//
//  DeleteChatUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 11/10/23.
//

import Foundation
import DataComponents

protocol RemoveChatUseCase {

    func execute(tag: Int64) async throws
}
