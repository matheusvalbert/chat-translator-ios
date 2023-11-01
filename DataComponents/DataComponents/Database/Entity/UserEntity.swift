//
//  UserEntity.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import CoreData

final class UserEntity: NSManagedObject {
    
    public static let name = "User"
    
    @NSManaged var username: String
    @NSManaged var tag: Int64
    @NSManaged var language: String
    
    static func description() -> NSEntityDescription {
        let entity = NSEntityDescription()
        entity.name = name
        entity.managedObjectClassName = NSStringFromClass(UserEntity.self)
        
        let usernameAttr = NSAttributeDescription()
        usernameAttr.name = "username"
        usernameAttr.attributeType = .stringAttributeType
        usernameAttr.isOptional = false
        
        let tagAttr = NSAttributeDescription()
        tagAttr.name = "tag"
        tagAttr.attributeType = .integer64AttributeType
        tagAttr.isOptional = false
        
        let languageAttr = NSAttributeDescription()
        languageAttr.name = "language"
        languageAttr.attributeType = .stringAttributeType
        languageAttr.isOptional = false
        
        entity.properties = [usernameAttr, tagAttr, languageAttr]
        
        return entity
    }
}
