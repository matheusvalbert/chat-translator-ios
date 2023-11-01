//
//  UserDao.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation
import CoreData

public final class UserDao {
    
    let appDatabase: AppDatabase
    
    public init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }
    
    func fetch() async throws -> UserEntity {
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: UserEntity.name)
        
        let users = try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().fetch(fetchRequest)
        }
        
        return users[0]
    }
    
    func insert(username: String, tag: Int64, language: String) async throws {
        let entity = NSEntityDescription.insertNewObject(forEntityName: UserEntity.name, into: appDatabase.getContext()) as! UserEntity
        
        entity.username = username
        entity.tag = tag
        entity.language = language
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.getContext().save()
        }
    }
    
    func update(username: String, language: String) async throws {
        
        let updateRequest = NSFetchRequest<UserEntity>(entityName: UserEntity.name)
        
        try await appDatabase.backgroundContext().perform {
            let users = try self.appDatabase.getContext().fetch(updateRequest)
            let user = users.first!
            
            user.username = username
            user.language = language
            
            try self.appDatabase.getContext().save()
        }
    }
    
    func exists() async throws -> Bool {
        let existsRequest = NSFetchRequest<UserEntity>(entityName: UserEntity.name)
        
        let count = try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().count(for: existsRequest)
        }
        return count > 0 ? true : false
    }
}
