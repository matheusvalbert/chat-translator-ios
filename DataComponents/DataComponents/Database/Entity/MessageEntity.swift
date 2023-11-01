//
//  MessageEntity.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation
import CoreData

final class MessageEntity: NSManagedObject {
    
    public static let name = "Messages"
    
    @NSManaged var id: UUID
    @NSManaged var tag: Int64
    @NSManaged var message: String
    @NSManaged var date: Date?
    @NSManaged var translatedMessage: String?
    @NSManaged var senderOrReceiver: String
    @NSManaged var status: String
    
    static func description() -> NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = name
        entity.managedObjectClassName = NSStringFromClass(MessageEntity.self)
        
        let uuidAttr = NSAttributeDescription()
        uuidAttr.name = "id"
        uuidAttr.attributeType = .UUIDAttributeType
        uuidAttr.isOptional = false
        
        let friendTagAttr = NSAttributeDescription()
        friendTagAttr.name = "tag"
        friendTagAttr.attributeType = .integer64AttributeType
        friendTagAttr.isOptional = false
        
        let messageAttr = NSAttributeDescription()
        messageAttr.name = "message"
        messageAttr.attributeType = .stringAttributeType
        messageAttr.isOptional = false
        
        let dateAttr = NSAttributeDescription()
        dateAttr.name = "date"
        dateAttr.attributeType = .dateAttributeType
        dateAttr.isOptional = true
        
        let translatedMessageAttr = NSAttributeDescription()
        translatedMessageAttr.name = "translatedMessage"
        translatedMessageAttr.attributeType = .stringAttributeType
        translatedMessageAttr.isOptional = true
        
        let senderOrReceiverAttr = NSAttributeDescription()
        senderOrReceiverAttr.name = "senderOrReceiver"
        senderOrReceiverAttr.attributeType = .stringAttributeType
        senderOrReceiverAttr.isOptional = false
        
        let statusAttr = NSAttributeDescription()
        statusAttr.name = "status"
        statusAttr.attributeType = .stringAttributeType
        statusAttr.isOptional = false
        
        entity.properties = [uuidAttr, friendTagAttr, messageAttr, dateAttr, translatedMessageAttr, senderOrReceiverAttr, statusAttr]
        
        return entity
    }
}
