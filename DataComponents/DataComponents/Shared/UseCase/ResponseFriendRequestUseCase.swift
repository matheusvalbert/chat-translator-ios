//
//  ResponseFriendRequestUseCase.swift
//  DataComponents
//
//  Created by Matheus Valbert on 24/10/23.
//

import Foundation

public protocol ResponseFriendRequestUseCase {

    func execute(tag: Int64, status: FriendStatus) async throws
}
