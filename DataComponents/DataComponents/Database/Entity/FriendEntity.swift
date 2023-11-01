//
//  FriendEntity.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation
import CoreData

final class FriendEntity: NSManagedObject {
    
    public static let name = "Friends"
    
    @NSManaged var username: String
    @NSManaged var tag: Int64
    @NSManaged var status: String
    
    static func description() -> NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = name
        entity.managedObjectClassName = NSStringFromClass(FriendEntity.self)
        
        let usernameAttr = NSAttributeDescription()
        usernameAttr.name = "username"
        usernameAttr.attributeType = .stringAttributeType
        usernameAttr.isOptional = false
        
        let tagAttr = NSAttributeDescription()
        tagAttr.name = "tag"
        tagAttr.attributeType = .integer64AttributeType
        tagAttr.isOptional = false
        
        let statusAttr = NSAttributeDescription()
        statusAttr.name = "status"
        statusAttr.attributeType = .stringAttributeType
        statusAttr.isOptional = false
        
        entity.properties = [usernameAttr, tagAttr, statusAttr]
        
        return entity
    }
}
