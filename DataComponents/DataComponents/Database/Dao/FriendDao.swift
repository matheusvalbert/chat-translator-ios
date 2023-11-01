//
//  FriendDao.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation
import CoreData

public final class FriendDao {
    
    let appDatabase: AppDatabase
    
    public init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }
    
    func fetch() async throws -> [FriendEntity] {
        let fetchRequest = NSFetchRequest<FriendEntity>(entityName: FriendEntity.name)
        
        let sortStatus = NSSortDescriptor(key: "status", ascending: true)
        let sortName = NSSortDescriptor(key: "username", ascending: true)
        
        fetchRequest.sortDescriptors = [sortStatus, sortName]
        
        return try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().fetch(fetchRequest)
        }
    }
    
    func fetch(byStatus status: FriendStatus) async throws -> [FriendEntity] {
        let fetchRequest = NSFetchRequest<FriendEntity>(entityName: FriendEntity.name)
        
        let statusPredicate = NSPredicate(format: "status == %@", status.rawValue as CVarArg)
        let sortName = NSSortDescriptor(key: "username", ascending: true)
        
        fetchRequest.predicate = statusPredicate
        fetchRequest.sortDescriptors = [sortName]
        
        let friends = try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().fetch(fetchRequest)
        }
        
        return friends
    }
    
    func insert(friends: [[String : Any]]) async throws {
        
        let batchInsertRequest = NSBatchInsertRequest(entityName: FriendEntity.name, objects: friends)
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.backgroundContext().execute(batchInsertRequest)
            try self.appDatabase.getContext().save()
        }
    }
    
    func delete() async throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: FriendEntity.name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.backgroundContext().execute(deleteRequest)
            try self.appDatabase.getContext().save()
        }
    }
    
    func exists(tag: Int64) async throws -> Bool {
        let fetchRequest = NSFetchRequest<FriendEntity>(entityName: FriendEntity.name)
        
        let tagPredicate = NSPredicate(format: "tag == %lld", tag)
        
        fetchRequest.predicate = tagPredicate
        
        return try await appDatabase.backgroundContext().perform {
            return try !self.appDatabase.getContext().fetch(fetchRequest).isEmpty
        }
    }
}
