//
//  MessageDao.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation
import CoreData

public final class MessageDao {
    
    let appDatabase: AppDatabase
    
    public init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }
    
    func insert(id: UUID, tag: Int64, message: String, date: Date?, translatedMessage: String, senderOrReceiver: SenderOrReceiver, status: MessageStatus) async throws {
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: MessageEntity.name, into: appDatabase.getContext()) as! MessageEntity
        
        entity.id = id
        entity.tag = tag
        entity.message = message
        entity.date = date
        entity.translatedMessage = translatedMessage
        entity.senderOrReceiver = senderOrReceiver.rawValue
        entity.status = status.rawValue
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.getContext().save()
        }
    }
    
    func insert(messages: [[String : Any]]) async throws {
        
        let batchInsertRequest = NSBatchInsertRequest(entityName: MessageEntity.name, objects: messages)
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.backgroundContext().execute(batchInsertRequest)
            try self.appDatabase.getContext().save()
        }
    }
    
    func fetch(byTag tag: Int64) async throws -> [MessageEntity] {
        
        let fetchRequest = NSFetchRequest<MessageEntity>(entityName: MessageEntity.name)
        
        let tagPredicate = NSPredicate(format: "tag == %lld", tag)
        let sortDate = NSSortDescriptor(key: "date", ascending: true)
        
        fetchRequest.predicate = tagPredicate
        fetchRequest.sortDescriptors = [sortDate]
        
        return try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().fetch(fetchRequest)
        }
    }
    
    func fetch(byId id: UUID) async throws -> MessageEntity {
        
        let fetchRequest = NSFetchRequest<MessageEntity>(entityName: MessageEntity.name)
        
        let statusPredicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        fetchRequest.predicate = statusPredicate
        fetchRequest.fetchLimit = 1
        
        return try await appDatabase.backgroundContext().perform {
            return try self.appDatabase.getContext().fetch(fetchRequest)[0]
        }
    }
    
    func update(id: UUID, date: Date, status: MessageStatus) async throws {
        
        let message = try await fetch(byId: id)
        
        message.date = date
        message.status = status.rawValue
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.getContext().save()
        }
    }
    
    func remove(byTag tag: Int64) async throws {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: MessageEntity.name)
        fetchRequest.predicate = NSPredicate(format: "tag == %lld", tag)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.backgroundContext().execute(batchDeleteRequest)
            try self.appDatabase.getContext().save()
        }
    }
    
    func delete() async throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MessageEntity.name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try await appDatabase.backgroundContext().perform {
            try self.appDatabase.backgroundContext().execute(deleteRequest)
            try self.appDatabase.getContext().save()
        }
    }
}
