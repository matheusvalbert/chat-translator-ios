//
//  FriendRepositoryImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation

final class FriendRepositoryImpl: FriendRepository {
    
    private let friendService: FriendService
    private let friendDao: FriendDao
    
    init(friendService: FriendService, friendDao: FriendDao) {
        self.friendService = friendService
        self.friendDao = friendDao
    }
    
    func reloadFriendData() async throws {
        let friends = try await friendService.list().friends
        
        try await friendDao.delete()
        
        if friends?.isEmpty == false {
            let data = FriendDomain.listResponseToFriendEntity(list: friends!)
            try await friendDao.insert(friends: data.encodeToEntity())
        }
    }
    
    func fetch() async throws -> [FriendDomain] {
        var friends: [FriendDomain] = []
        let friendsEntity = try await friendDao.fetch()
        
        for friendEntity in friendsEntity {
            let friend = FriendDomain(username: friendEntity.username, tag: friendEntity.tag, status: friendEntity.status)
            friends.append(friend)
        }
        
        return friends
    }
    
    func fetchAccepted() async throws -> [FriendDomain] {
        var friends: [FriendDomain] = []
        let friendsEntity = try await friendDao.fetch(byStatus: .accepted)
        
        for friendEntity in friendsEntity {
            let friend = FriendDomain(username: friendEntity.username, tag: friendEntity.tag, status: friendEntity.status)
            friends.append(friend)
        }
        
        return friends
    }
    
    func request(username: String, tag: Int64) async throws {
        try await friendService.request(data: RequestRequest(username: username, tag: tag))
    }
    
    func response(tag: Int64, status: FriendStatus) async throws {
        try await friendService.response(data: ResponseRequest(tag: tag, status: status.rawValue))
    }
    
    func exists(byTag tag: Int64) async throws -> Bool {
        return try await friendDao.exists(tag: tag)
    }
    
    func count(byStatus status: FriendStatus) async throws -> Int {
        return Int(try await friendDao.fetch(byStatus: .waiting).count)
    }
}
