//
//  MessageDecoder.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import Foundation

struct MessageReceived: Decodable {
    let type: MessageType
    let username: String
    let tag: Int64
    let message: String
    
    enum CodingKeys: CodingKey {
        case type
        case username
        case tag
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try MessageType(rawValue: container.decode(String.self, forKey: .type))!
        self.username = try container.decode(String.self, forKey: .username)
        if let tagString = try? container.decode(String.self, forKey: .tag),
           let tagInt64 = Int64(tagString) {
            self.tag = tagInt64
        } else {
            throw DecodingError.dataCorruptedError(forKey: .tag, in: container, debugDescription: "Tag is not a valid Int64")
        }
        self.message = try container.decode(String.self, forKey: .message)

    }
    
    init(from hash: [AnyHashable : Any]) {
        self.type = MessageType(rawValue: hash["type"] as! String)!
        self.username = hash["username"] as! String
        self.tag = Int64(hash["tag"] as! String)!
        self.message = hash["message"] as! String
    }
}
