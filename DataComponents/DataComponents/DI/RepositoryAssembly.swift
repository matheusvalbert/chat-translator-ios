//
//  RepositoryAssembly.swift
//  DataComponents
//
//  Created by Matheus Valbert on 28/08/23.
//

import Foundation
import Swinject

public final class RepositoryAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(FirebaseRepository.self) { resolver in
            return FirebaseRepositoryImpl()
        }
        
        container.register(UserRepository.self) { resolver in
            guard let userService = resolver.resolve(UserService.self) else {
                fatalError("user service dependency could not be resolved")
            }
            
            guard let userDao = resolver.resolve(UserDao.self) else {
                fatalError("user dao dependency could not be resolved")
            }
            
            return UserRepositoryImpl(userService: userService, userDao: userDao)
        }
        
        container.register(FriendRepository.self) { resolver in
            guard let friendService = resolver.resolve(FriendService.self) else {
                fatalError("friend service dependency could not be resolved")
            }
            
            guard let friendDao = resolver.resolve(FriendDao.self) else {
                fatalError("friend dao dependency could not be resolved")
            }
            
            return FriendRepositoryImpl(friendService: friendService, friendDao: friendDao)
        }
        
        container.register(ChatRepository.self) { resolver in
            
            guard let chatDao = resolver.resolve(ChatDao.self) else {
                fatalError("chat dao dependency could not be resolved")
            }
            
            guard let chatEventBus = resolver.resolve(ChatEventBus.self) else {
                fatalError("chat event bus dependency could not be resolved")
            }
            
            return ChatRepositoryImpl(chatDao: chatDao, chatEventBus: chatEventBus)
        }
        
        container.register(MessageRepository.self) { resolver in
            
            guard let messageService = resolver.resolve(MessageService.self) else {
                fatalError("message service dependency could not be resolved")
            }
            
            guard let messageDao = resolver.resolve(MessageDao.self) else {
                fatalError("message dao dependency could not be resolved")
            }
            
            guard let messageEventBus = resolver.resolve(MessageEventBus.self) else {
                fatalError("message event bus dependency could not be resolved")
            }
            
            return MessageRepositoryImpl(messageService: messageService, messageDao: messageDao, messageEventBus: messageEventBus)
        }
    }
}
