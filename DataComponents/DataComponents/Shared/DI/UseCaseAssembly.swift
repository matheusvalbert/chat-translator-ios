//
//  UseCaseAssembly.swift
//  DataComponents
//
//  Created by Matheus Valbert on 09/10/23.
//

import Foundation
import Swinject

public final class UseCaseAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Swinject.Container) {
        
        container.register(ReloadFriendsListUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            guard let exposedCoordinator = resolver.resolve(ExposedCoordinator.self) else {
                fatalError("exposed coordinator dependency could not be resolved")
            }
            
            return ReloadFriendsListUseCaseImpl(friendRepository: friendRepository, chatRepository: chatRepository, exposedCoordinator: exposedCoordinator)
        }
        
        container.register(ResponseFriendRequestUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            return ResponseFriendRequestUseCaseImpl(friendRepository: friendRepository)
        }
        
        container.register(ReceiveMessagesUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            guard let messageRepository = resolver.resolve(MessageRepository.self) else {
                fatalError("message repository dependency could not be resolved")
            }
            
            guard let exposedCoordinator = resolver.resolve(ExposedCoordinator.self) else {
                fatalError("exposed coordinator dependency could not be resolved")
            }
            
            return ReceiveMessagesUseCaseImpl(friendRepository: friendRepository, chatRepository: chatRepository, messageRepository: messageRepository, exposedCoordinator: exposedCoordinator)
        }
        
        container.register(SendFirebaseTokenUseCase.self) { resolver in
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            return SendFirebaseTokenUseCaseImpl(userRepository: userRepository)
        }
        
        container.register(SendMessageUseCase.self) { resolver in
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            guard let messageRepository = resolver.resolve(MessageRepository.self) else {
                fatalError("message repository dependency could not be resolved")
            }
            
            return SendMessageUseCaseImpl(chatRepository: chatRepository, messageRepository: messageRepository)
        }
    }
}
