//
//  List.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation

struct FriendListResponse: Codable {
    let username: String
    let tag: Int64
    let status: String
}

struct ListResponse: Codable {
    let friends: [FriendListResponse]?
}
