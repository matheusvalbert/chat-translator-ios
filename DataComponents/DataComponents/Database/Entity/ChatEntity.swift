//
//  ChatEntity.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation
import CoreData

final class ChatEntity: NSManagedObject {
    
    public static let name = "Chats"
    
    @NSManaged var tag: Int64
    @NSManaged var lastMessage: String
    @NSManaged var unreadMessages: Int16
    
    static func description(friend: NSEntityDescription, message: NSEntityDescription) -> NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = name
        entity.managedObjectClassName = NSStringFromClass(ChatEntity.self)
        
        let tagRel = NSAttributeDescription()
        tagRel.name = "tag"
        tagRel.attributeType = .integer64AttributeType
        tagRel.isOptional = false
        
        let lastMessage = NSAttributeDescription()
        lastMessage.name = "lastMessage"
        lastMessage.attributeType = .stringAttributeType
        lastMessage.isOptional = false
        
        let unreadMessagesAttr = NSAttributeDescription()
        unreadMessagesAttr.name = "unreadMessages"
        unreadMessagesAttr.attributeType = .integer16AttributeType
        unreadMessagesAttr.isOptional = false
        
        entity.properties = [tagRel, lastMessage, unreadMessagesAttr]
        
        return entity
    }
}
