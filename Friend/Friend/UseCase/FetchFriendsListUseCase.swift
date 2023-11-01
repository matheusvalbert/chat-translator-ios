//
//  FetchFriendsListUseCase.swift
//  Friend
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation
import DataComponents

protocol FetchFriendsListUseCase {

    func execute() async throws -> [FriendDomain]
}
