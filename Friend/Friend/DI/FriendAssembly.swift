//
//  FriendAssembly.swift
//  Friend
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation
import Swinject
import DataComponents

public final class FriendAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(FetchFriendsListUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            return FetchFriendsListUseCaseImpl(friendRepository: friendRepository)
        }
        
        container.register(SendFriendRequestUseCase.self) { resolver in
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            return SendFriendRequestUseCaseImpl(friendRepository: friendRepository)
        }
        
        container.register(FriendViewModel.self) { resolver in
            
            guard let fetchFriendsListUseCase = resolver.resolve(FetchFriendsListUseCase.self) else {
                fatalError("fetch friends list use case dependency could not be resolved")
            }
            
            guard let reloadFriendsListUseCase = resolver.resolve(ReloadFriendsListUseCase.self) else {
                fatalError("reload friends list use case dependency could not be resolved")
            }
            
            guard let sendFriendRequestUseCase = resolver.resolve(SendFriendRequestUseCase.self) else {
                fatalError("send friend request use case dependency could not be resolved")
            }
            
            guard let responseFriendRequestUseCase = resolver.resolve(ResponseFriendRequestUseCase.self) else {
                fatalError("response friend request use case dependency could not be resolved")
            }
            
            return FriendViewModel(fetchFriendsListUseCase: fetchFriendsListUseCase, reloadFriendsListUseCase: reloadFriendsListUseCase, sendFriendRequestUseCase: sendFriendRequestUseCase, responseFriendRequestUseCase: responseFriendRequestUseCase)
        }.inObjectScope(.container)
    }
}
