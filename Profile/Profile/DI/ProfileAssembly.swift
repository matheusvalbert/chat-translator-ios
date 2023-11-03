//
//  ProfileAssembly.swift
//  Profile
//
//  Created by Matheus Valbert on 01/09/23.
//

import Foundation
import Swinject
import DataComponents

public final class ProfileAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(FetchProfileUseCase.self) { resolver in
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            return FetchProfileUseCaseImpl(userRepository: userRepository)
        }
        
        container.register(FetchUserProfileFromServerUseCase.self) { resolver in
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            return FetchUserProfileFromServerUseCaseImpl(userRepository: userRepository)
        }
        
        container.register(UpdateProfileUseCase.self) { resolver in
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            return UpdateProfileUseCaseImpl(userRepository: userRepository)
        }
        
        container.register(DeleteAccountUseCase.self) { resolver in
            
            guard let firebaseRepository = resolver.resolve(FirebaseRepository.self) else {
                fatalError("firebase repository dependency could not be resolved")
            }
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            guard let chatRepository = resolver.resolve(ChatRepository.self) else {
                fatalError("chat repository dependency could not be resolved")
            }
            
            guard let messageRepository = resolver.resolve(MessageRepository.self) else {
                fatalError("message repository dependency could not be resolved")
            }
            
            return DeleteAccountUseCaseImpl(firebaseRepository: firebaseRepository, userRepository: userRepository, friendRepository: friendRepository, chatRepository: chatRepository, messageRepository: messageRepository)
        }
        
        container.register(ProfileViewModel.self) { resolver in
            
            guard let fetchProfileUseCase = resolver.resolve(FetchProfileUseCase.self) else {
                fatalError("fetch profile use case dependency could not be resolved")
            }
            
            guard let fetchUserProfileFromServerUseCase = resolver.resolve(FetchUserProfileFromServerUseCase.self) else {
                fatalError("fetch profile use case dependency could not be resolved")
            }
            
            guard let updateProfileUseCase = resolver.resolve(UpdateProfileUseCase.self) else {
                fatalError("update profile use case dependency could not be resolved")
            }
            
            guard let deleteAccountUseCase = resolver.resolve(DeleteAccountUseCase.self) else {
                fatalError("delete account use case dependency could not be resolved")
            }
            
            return ProfileViewModel(fetchProfileUseCase: fetchProfileUseCase, updateProfileUseCase: updateProfileUseCase, fetchUserProfileFromServerUseCase: fetchUserProfileFromServerUseCase, deleteAccountUseCase: deleteAccountUseCase)
        }.inObjectScope(.container)
    }
}
