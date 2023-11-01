//
//  ChatsViewModel.swift
//  Chats
//
//  Created by Matheus Valbert on 18/09/23.
//

import Foundation
import DataComponents
import Combine

public final class ChatsViewModel {
    
    private let fetchChatsUseCase: FetchChatsUseCase
    private let sendMessageUseCase: SendMessageUseCase
    private let retrySendMessageUseCase: RetrySendMessageUseCase
    private let fetchMessagesUseCase: FetchMessagesUseCase
    private let updateChatsUseCase: UpdateChatsUseCase
    private let updateMessagesUseCase: UpdateMessagesUseCase
    private let removeUnreadMessagesUseCase: RemoveUnreadMessagesUseCase
    private let removeChatUseCase: RemoveChatUseCase
    private let resetUnreadMessagesCounterUseCase: ResetUnreadMessagesCounterUseCase
    private let receiveMessagesUseCase: ReceiveMessagesUseCase
    
    private let chatEventBus: ChatEventBus
    private var chatCancellable = Set<AnyCancellable>()
    private let messageEventBus: MessageEventBus
    private var messageCancellable = Set<AnyCancellable>()
    
    var friends: [FriendDomain] = []
    var selectedFriend: FriendDomain?
    
    @Published var chats: [ChatDomain] = []
    @Published var messages: [MessageDomain] = []
    
    init(fetchChatsUseCase: FetchChatsUseCase, sendMessageUseCase: SendMessageUseCase, retrySendMessageUseCase: RetrySendMessageUseCase, fetchMessagesUseCase: FetchMessagesUseCase, updateChatsUseCase: UpdateChatsUseCase, updateMessagesUseCase: UpdateMessagesUseCase, removeUnreadMessagesUseCase: RemoveUnreadMessagesUseCase, removeChatUseCase: RemoveChatUseCase, resetUnreadMessagesCounterUseCase: ResetUnreadMessagesCounterUseCase, receiveMessagesUseCase: ReceiveMessagesUseCase, chatEventBus: ChatEventBus, messageEventBus: MessageEventBus) {
        self.fetchChatsUseCase = fetchChatsUseCase
        self.sendMessageUseCase = sendMessageUseCase
        self.retrySendMessageUseCase = retrySendMessageUseCase
        self.fetchMessagesUseCase = fetchMessagesUseCase
        self.updateChatsUseCase = updateChatsUseCase
        self.updateMessagesUseCase = updateMessagesUseCase
        self.removeUnreadMessagesUseCase = removeUnreadMessagesUseCase
        self.removeChatUseCase = removeChatUseCase
        self.resetUnreadMessagesCounterUseCase = resetUnreadMessagesCounterUseCase
        self.receiveMessagesUseCase = receiveMessagesUseCase
        
        self.chatEventBus = chatEventBus
        self.messageEventBus = messageEventBus
        
        Task {
            try await self.receiveMessagesUseCase.execute()
        }
        
        chatEventBus.event.sink { chat in
            self.chats = updateChatsUseCase.execute(oldChats: self.chats, newChat: chat)
        }.store(in: &chatCancellable)
        
        messageEventBus.event.sink { message in
            self.messages = updateMessagesUseCase.execute(oldMessages: self.messages, newMessage: message)
        }.store(in: &messageCancellable)
    }
    
    public func fetchChats() async {
        do {
            let data = try await fetchChatsUseCase.execute()
            friends = data.friends
            chats = data.chats
        } catch {
            print(error)
            fatalError("Chats list not found")
        }
    }
    
    func sendMessage(message: String) async {
        do {
            try await sendMessageUseCase.execute(tag: selectedFriend!.tag, message: message)
        } catch {
            print(error)
            fatalError("Error to send message")
        }
    }
    
    func retrySendMessage(id: UUID) async {
        do {
            try await retrySendMessageUseCase.execute(id: id)
        } catch {
            print(error)
            fatalError("Error to retry send message")
        }
    }
    
    func fetchMessages() async {
        do {
            messages = try await fetchMessagesUseCase.execute(tag: selectedFriend!.tag)
        } catch {
            print(error)
            fatalError("Error to fetch messages")
        }
    }
    
    func removeMessages() {
        messages = []
        Task {
            try await resetUnreadMessagesCounterUseCase.execute(tag: selectedFriend!.tag)
        }
    }
    
    func removeChat(tag: Int64) {
        Task {
            do {
                try await removeChatUseCase.execute(tag: tag)
                await fetchChats()
            } catch {
                print(error)
                fatalError("Error to delete chat")
            }
        }
    }
    
    public func navigateToMessages(friend: FriendDomain) {
        selectedFriend = friend
        Task {
            do {
                try await removeUnreadMessagesUseCase.execute(tag: selectedFriend!.tag)
            } catch {
                print(error)
                fatalError("Error to remove unread messages")
            }
        }
    }
    
    deinit {
        chatCancellable.forEach { $0.cancel() }
        messageCancellable.forEach { $0.cancel() }
    }
}
