//
//  FetchChatsUseCase.swift
//  Chats
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation
import DataComponents

protocol FetchChatsUseCase {

    func execute() async throws -> (friends: [FriendDomain], chats: [ChatDomain])
}
