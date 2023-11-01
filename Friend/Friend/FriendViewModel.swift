//
//  FriendViewModel.swift
//  Friend
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation
import DataComponents

public final class FriendViewModel {
    
    private let fetchFriendsListUseCase: FetchFriendsListUseCase
    private let reloadFriendsListUseCase: ReloadFriendsListUseCase
    private let sendFriendRequestUseCase: SendFriendRequestUseCase
    private let responseFriendRequestUseCase: ResponseFriendRequestUseCase
    
    public var friends: [FriendDomain] = []
    public var selectedIndex: Int?
    
    init(fetchFriendsListUseCase: FetchFriendsListUseCase, reloadFriendsListUseCase: ReloadFriendsListUseCase, sendFriendRequestUseCase: SendFriendRequestUseCase, responseFriendRequestUseCase: ResponseFriendRequestUseCase) {
        self.fetchFriendsListUseCase = fetchFriendsListUseCase
        self.reloadFriendsListUseCase = reloadFriendsListUseCase
        self.sendFriendRequestUseCase = sendFriendRequestUseCase
        self.responseFriendRequestUseCase = responseFriendRequestUseCase
    }
    
    public func fetch() async {
        do {
            friends = try await fetchFriendsListUseCase.execute()
        } catch {
            print(error)
            fatalError("Friends list not found")
        }
    }
    
    public func reload() async {
        do {
            try await reloadFriendsListUseCase.execute()
            friends = try await fetchFriendsListUseCase.execute()
        } catch {
            print(error)
            fatalError("Friends reload error")
        }
    }
    
    func request(user: String) async -> Bool {
        do {
            try await sendFriendRequestUseCase.execute(user: user)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func response(tag: Int64, status: FriendStatus) async -> Bool {
        do {
            try await responseFriendRequestUseCase.execute(tag: tag, status: status)
            return true
        } catch {
            print(error)
            return false
        }
    }
}
