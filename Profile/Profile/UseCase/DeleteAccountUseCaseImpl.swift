//
//  DeleteAccountUseCaseImpl.swift
//  Profile
//
//  Created by Matheus Valbert on 03/11/23.
//

import Foundation
import DataComponents

final class DeleteAccountUseCaseImpl: DeleteAccountUseCase {
    
    private let firebaseRepository: FirebaseRepository
    private let userRepository: UserRepository
    private let friendRepository: FriendRepository
    private let chatRepository: ChatRepository
    private let messageRepository: MessageRepository
    
    init(firebaseRepository: FirebaseRepository, userRepository: UserRepository, friendRepository: FriendRepository, chatRepository: ChatRepository, messageRepository: MessageRepository) {
        self.firebaseRepository = firebaseRepository
        self.userRepository = userRepository
        self.friendRepository = friendRepository
        self.chatRepository = chatRepository
        self.messageRepository = messageRepository
    }
    
    func execute() async throws {
        try await userRepository.delete()
        try await friendRepository.delete()
        try await chatRepository.delete()
        try await messageRepository.delete()
        try await firebaseRepository.deleteAccount()
    }
}
