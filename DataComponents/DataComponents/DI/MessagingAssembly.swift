//
//  MessagingAssembly.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import Foundation
import Swinject

public final class MessagingAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(FriendMessage.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could no be resolved")
            }
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could no be resolved")
            }
            
            guard let reloadFriendsListUseCase = resolver.resolve(ReloadFriendsListUseCase.self) else {
                fatalError("reload friends list use case dependency could not be resolved")
            }
            
            guard let responseFriendRequestUseCase = resolver.resolve(ResponseFriendRequestUseCase.self) else {
                fatalError("response friend request use case dependency could not be resolved")
            }
            
            guard let exposedCoordinator = resolver.resolve(ExposedCoordinator.self) else {
                fatalError("exposed coordinator dependency could no be resolved")
            }
            
            return FriendMessage(friendRepository: friendRepository, chatRepository: chatRepository, reloadFriendsListUseCase: reloadFriendsListUseCase, responseFriendRequestUseCase: responseFriendRequestUseCase, exposedCoordinator: exposedCoordinator)
        }
        
        container.register(MessageMessage.self) { resolver in
            
            guard let receiveMessagesUseCase = resolver.resolve(ReceiveMessagesUseCase.self) else {
                fatalError("receive messages use case dependency could not be resolved")
            }
            
            guard let sendMessageUseCase = resolver.resolve(SendMessageUseCase.self) else {
                fatalError("send message use case dependency could not be resolved")
            }
            
            guard let exposedCoordinator = resolver.resolve(ExposedCoordinator.self) else {
                fatalError("exposed coordinator dependency could no be resolved")
            }
            
            return MessageMessage(receiveMessagesUseCase: receiveMessagesUseCase, sendMessageUseCase: sendMessageUseCase, exposedCoordinator: exposedCoordinator)
        }
        
        container.register(MessagingSelector.self) { resolver in
            
            guard let friendMessage = resolver.resolve(FriendMessage.self) else {
                fatalError("friend message dependency could not be resolved")
            }
            
            guard let messageMessage = resolver.resolve(MessageMessage.self) else {
                fatalError("message message dependency could not be resolved")
            }
            
            return MessagingSelector(friendMessage: friendMessage, messageMessage: messageMessage)
        }
    }
}
