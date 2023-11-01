//
//  FetchMessagesUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 02/10/23.
//

import Foundation
import DataComponents

protocol FetchMessagesUseCase {

    func execute(tag: Int64) async throws -> [MessageDomain]
}
