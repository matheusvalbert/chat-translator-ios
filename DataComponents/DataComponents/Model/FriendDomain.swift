//
//  FriendDomain.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation

public struct FriendDomain: Codable {
    
    public var username: String
    public var tag: Int64
    public var status: FriendStatus

    enum CodingKeys: String, CodingKey {
        case username
        case tag
        case status
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        tag = try container.decode(Int64.self, forKey: .tag)
        status = FriendStatus(rawValue: try container.decode(String.self, forKey: .status))!
    }
    
    public init(username: String, tag: Int64, status: String) {
        self.username = username
        self.tag = tag
        self.status = FriendStatus(rawValue: status)!
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(tag, forKey: .tag)
        try container.encode(status.rawValue, forKey: .status)
    }
    
    static func listResponseToFriendEntity(list: [FriendListResponse]) -> [FriendDomain] {
        
        return list.map { item in
            return FriendDomain(username: item.username, tag: item.tag, status: item.status)
        }
    }
}
