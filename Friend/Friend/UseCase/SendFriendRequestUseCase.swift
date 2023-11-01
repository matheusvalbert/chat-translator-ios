//
//  SendFriendRequestUseCase.swift
//  Friend
//
//  Created by Matheus Valbert on 13/09/23.
//

import Foundation
import DataComponents

protocol SendFriendRequestUseCase {

    func execute(user: String) async throws
}
