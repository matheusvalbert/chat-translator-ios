//
//  ChatDao.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation
import CoreData

public final class ChatDao {
    
    let appDatabase: AppDatabase
    
    public init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }
    
    func insert(tag: Int64, lastMessage: String, incrementUnreadMessages: Bool) async throws {
        let entity = NSEntityDescription.insertNewObject(forEntityName: ChatEntity.name, into: appDatabase.getContext()) as! ChatEntity
        
        entity.tag = tag
        entity.lastMessage = lastMessage
        entity.unreadMessages = incrementUnreadMessages ? 1 : 0
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.getContext().save()
        }
    }
    
    func update(tag: Int64, message: String, incrementUnreadMessages: Bool) async throws -> Int16 {
        let chat = try await fetch(byTag: tag)
        
        chat.lastMessage = message
        chat.unreadMessages += incrementUnreadMessages ? 1 : 0
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.getContext().save()
        }
        
        return chat.unreadMessages
    }
    
    func fetch(byTag tag: Int64) async throws -> ChatEntity {
        let fetchRequest = NSFetchRequest<ChatEntity>(entityName: ChatEntity.name)
        
        let statusPredicate = NSPredicate(format: "tag == %lld", tag)
        
        fetchRequest.predicate = statusPredicate
        fetchRequest.fetchLimit = 1
        
        return try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().fetch(fetchRequest)[0]
        }
    }
    
    func fetch() async throws -> [ChatEntity] {
        
        let fetchRequest = NSFetchRequest<ChatEntity>(entityName: ChatEntity.name)
        
        return try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().fetch(fetchRequest)
        }
    }
    
    func exists(tag: Int64) async throws -> Bool {
        let fetchRequest = NSFetchRequest<ChatEntity>(entityName: ChatEntity.name)
        
        let tagPredicate = NSPredicate(format: "tag == %lld", tag)
        
        fetchRequest.predicate = tagPredicate
        
        return try await appDatabase.backgroundContext().perform {
            return try !self.appDatabase.getContext().fetch(fetchRequest).isEmpty
        }
    }
    
    func removeUnreadMessages(tag: Int64) async throws {
        let chat = try await fetch(byTag: tag)
        
        chat.unreadMessages = 0
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.getContext().save()
        }
    }
    
    func remove(byTag tag: Int64) async throws {
        
        let context = appDatabase.backgroundContext()
        
        let fetchRequest = NSFetchRequest<ChatEntity>(entityName: ChatEntity.name)
        
        let tagPredicate = NSPredicate(format: "tag == %lld", tag)
        
        fetchRequest.predicate = tagPredicate
        
        try await context.perform {
            if let object = try context.fetch(fetchRequest).first {
                context.delete(object)
                try context.save()
            }
        }
    }
    
    func delete() async throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ChatEntity.name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.backgroundContext().execute(deleteRequest)
            try self.appDatabase.getContext().save()
        }
    }
}
