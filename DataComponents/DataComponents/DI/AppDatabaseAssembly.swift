//
//  AppDatabaseAssembly.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation
import Swinject

public final class AppDatabaseAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(AppDatabase.self) { resolver in
            return AppDatabase()
        }
        
        container.register(UserDao.self) { resolver in
            
            guard let appDatabase = resolver.resolve(AppDatabase.self) else {
                fatalError("app database dependency could not be resolved")
            }
            
            return UserDao(appDatabase: appDatabase)
        }
        
        container.register(FriendDao.self) { resolver in
            
            guard let appDatabase = resolver.resolve(AppDatabase.self) else {
                fatalError("app database dependency could not be resolved")
            }
            
            return FriendDao(appDatabase: appDatabase)
        }
        
        container.register(ChatDao.self) { resolver in
            
            guard let appDatabase = resolver.resolve(AppDatabase.self) else {
                fatalError("app database dependency could not be resolved")
            }
            
            return ChatDao(appDatabase: appDatabase)
        }
        
        container.register(MessageDao.self) { resolver in
            
            guard let appDatabase = resolver.resolve(AppDatabase.self) else {
                fatalError("app database dependency could not be resolved")
            }
            
            return MessageDao(appDatabase: appDatabase)
        }
    }
}
