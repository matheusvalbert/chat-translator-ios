//
//  RemoveUnreadMessagesUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 11/10/23.
//

import Foundation

protocol RemoveUnreadMessagesUseCase {

    func execute(tag: Int64) async throws
}
