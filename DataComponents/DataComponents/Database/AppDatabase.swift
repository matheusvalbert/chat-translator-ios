//
//  AppDatabase.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import CoreData

public class AppDatabase {
    
    private let persistentContainerInstance: NSPersistentContainer
    
    public init() {
        persistentContainerInstance = AppDatabase.persistentContainer(managedObjectModel: AppDatabase.managedObjectModel())
        let _ = getContext()
    }
    
    private static func managedObjectModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        model.entities = generateEntities()
        return model
    }
    
    private static func generateEntities() -> ([NSEntityDescription]) {
        let user: NSEntityDescription = UserEntity.description()
        let friend: NSEntityDescription = FriendEntity.description()
        let message: NSEntityDescription = MessageEntity.description()
        let chat: NSEntityDescription = ChatEntity.description(friend: friend, message: message)
        
        return [user, friend, message, chat]
    }
    
    private static func persistentContainer(managedObjectModel: NSManagedObjectModel) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "AppDatabase", managedObjectModel: managedObjectModel)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainerInstance.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainerInstance.newBackgroundContext()
    }
    
    public func saveContext() {
        let context = persistentContainerInstance.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
