//
//  MessageRepository.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation

public protocol MessageRepository {
    
    func send(tag: Int64, message: String) async throws
    
    func retrySend(id: UUID) async throws

    func fetch(tag: Int64) async throws -> [MessageDomain]
    
    func receive() async throws -> [MessageDomain]
    
    func remove(tag: Int64) async throws
    
    func delete() async throws
}
