//
//  Send.swift
//  DataComponents
//
//  Created by Matheus Valbert on 21/09/23.
//

import Foundation

struct SendRequest: Codable {
    let tag: Int64
    let message: String
}

struct SendResponse: Codable {
    let date: Date
}
