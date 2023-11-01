//
//  ChatsAssembly.swift
//  Chats
//
//  Created by Matheus Valbert on 18/09/23.
//

import Foundation
import Swinject
import DataComponents

public final class ChatsAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(FetchChatsUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            return FetchChatsUseCaseImpl(friendRepository: friendRepository, chatRepository: chatRepository)
        }
        
        container.register(RetrySendMessageUseCase.self) { resolver in
            
            guard let messageRepository = resolver.resolve(MessageRepository.self) else {
                fatalError("message repository dependency could not be resolved")
            }
            
            return RetrySendMessageUseCaseImpl(messageRepository: messageRepository)
        }
        
        container.register(FetchMessagesUseCase.self) { resolver in
            
            guard let messageRepository = resolver.resolve(MessageRepository.self) else {
                fatalError("message repository dependency could not be resolved")
            }
            
            return FetchMessagesUseCaseImpl(messageRepository: messageRepository)
        }
        
        container.register(UpdateChatsUseCase.self) { resolver in
            
            return UpdateChatsUseCaseImpl()
        }
        
        container.register(UpdateMessagesUseCase.self) { resolver in
            
            return UpdateMessagesUseCaseImpl()
        }
        
        container.register(RemoveUnreadMessagesUseCase.self) { resolver in
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            return RemoveUnreadMessagesUseCaseImpl(chatRepository: chatRepository)
        }
        
        container.register(RemoveChatUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            guard let messageRepository = resolver.resolve(MessageRepository.self) else {
                fatalError("message repository dependency could not be resolved")
            }
            
            return RemoveChatUseCaseImpl(friendRepository: friendRepository, chatRepository: chatRepository, messageRepository: messageRepository)
        }
        
        container.register(ResetUnreadMessagesCounterUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            guard let exposedCoordinator = resolver.resolve(ExposedCoordinator.self) else {
                fatalError("exposed coordinator dependency could not be resolved")
            }
            
            return ResetUnreadMessagesCounterUseCaseImpl(friendRepository: friendRepository, chatRepository: chatRepository, exposedCoordinator: exposedCoordinator)
        }
        
        container.register(ChatsViewModel.self) { resolver in
            
            guard let fetchChatsUseCase = resolver.resolve(FetchChatsUseCase.self) else {
                fatalError("fetch chats use case dependency could not be resolved")
            }
            
            guard let sendMessageUseCase = resolver.resolve(SendMessageUseCase.self) else {
                fatalError("send message use case dependency could not be resolved")
            }
            
            guard let retrySendMessageUseCase = resolver.resolve(RetrySendMessageUseCase.self) else {
                fatalError("retry send message use case dependency could not be resolved")
            }
            
            guard let fetchMessagesUseCase = resolver.resolve(FetchMessagesUseCase.self) else {
                fatalError("fetch messages use case dependency could not be resolved")
            }
            
            guard let updateChatsUseCase = resolver.resolve(UpdateChatsUseCase.self) else {
                fatalError("update chats use case dependency could not be resolved")
            }
            
            guard let updateMessagesUseCase = resolver.resolve(UpdateMessagesUseCase.self) else {
                fatalError("update messages use case dependency could not be resolved")
            }
            
            guard let removeUnreadMessagesUseCase = resolver.resolve(RemoveUnreadMessagesUseCase.self) else {
                fatalError("remove unread messages use case dependency could not be resolved")
            }
            
            guard let removeChatUseCase = resolver.resolve(RemoveChatUseCase.self) else {
                fatalError("remove chat use case dependency could not be resolved")
            }
            
            guard let resetUnreadMessagesCounterUseCase = resolver.resolve(ResetUnreadMessagesCounterUseCase.self) else {
                fatalError("reset unread messages counter use case dependency could not be resolved")
            }
            
            guard let receiveMessagesUseCase = resolver.resolve(ReceiveMessagesUseCase.self) else {
                fatalError("receive messages use case dependency could not be resolved")
            }
            
            guard let chatEventBus = resolver.resolve(ChatEventBus.self) else {
                fatalError("chat event bus dependency could not be resolved")
            }
            
            guard let messageEventBus = resolver.resolve(MessageEventBus.self) else {
                fatalError("message event bus dependency could not be resolved")
            }
            
            return ChatsViewModel(fetchChatsUseCase: fetchChatsUseCase, sendMessageUseCase: sendMessageUseCase, retrySendMessageUseCase: retrySendMessageUseCase, fetchMessagesUseCase: fetchMessagesUseCase, updateChatsUseCase: updateChatsUseCase, updateMessagesUseCase: updateMessagesUseCase, removeUnreadMessagesUseCase: removeUnreadMessagesUseCase, removeChatUseCase: removeChatUseCase, resetUnreadMessagesCounterUseCase: resetUnreadMessagesCounterUseCase, receiveMessagesUseCase: receiveMessagesUseCase, chatEventBus: chatEventBus, messageEventBus: messageEventBus)
        }.inObjectScope(.container)
    }
}
