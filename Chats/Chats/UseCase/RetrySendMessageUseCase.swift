//
//  RetrySendMessageUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 04/10/23.
//

import Foundation

protocol RetrySendMessageUseCase {

    func execute(id: UUID) async throws
}
