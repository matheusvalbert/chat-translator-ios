//
//  FriendRepository.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation

public protocol FriendRepository {
    
    func reloadFriendData() async throws

    func fetch() async throws -> [FriendDomain]
    
    func fetchAccepted() async throws -> [FriendDomain]

    func request(username: String, tag: Int64) async throws

    func response(tag: Int64, status: FriendStatus) async throws
    
    func exists(byTag tag: Int64) async throws -> Bool
    
    func count(byStatus status: FriendStatus) async throws -> Int
    
    func delete() async throws
}
