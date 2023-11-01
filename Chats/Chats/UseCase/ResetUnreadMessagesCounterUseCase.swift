//
//  RemoveUnreadMessagesCounterUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 12/10/23.
//

import Foundation

protocol ResetUnreadMessagesCounterUseCase {

    func execute(tag: Int64) async throws
}
