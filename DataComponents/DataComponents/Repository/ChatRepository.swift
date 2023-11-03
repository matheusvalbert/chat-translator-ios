//
//  ChatRepository.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation

public protocol ChatRepository {
    
    func insert(tag: Int64, message: String, incrementUnreadMessages: Bool) async throws
    
    func update(tag: Int64, message: String, incrementUnreadMessages: Bool) async throws
    
    func fetch() async throws -> [ChatDomain]
    
    func exists(tag: Int64) async throws -> Bool
    
    func removeUnreadMessages(tag: Int64) async throws
    
    func remove(tag: Int64) async throws
    
    func getUnreadMessagesCount() async throws -> Int
    
    func delete() async throws
}
