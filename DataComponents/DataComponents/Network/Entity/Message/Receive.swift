//
//  Receive.swift
//  DataComponents
//
//  Created by Matheus Valbert on 04/10/23.
//

import Foundation

struct ReceiveSenderResponse: Codable {
    let username: String
    let tag: Int64
}

struct ReceiveResponse: Codable {
    let id: UUID
    let sender: ReceiveSenderResponse
    let message: String
    let translatedMessage: String
    let timestamp: Date
}

struct ListReceiveResponse: Codable {
    let messages: [ReceiveResponse]?
}
