//
//  Login.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation

struct LoginResponse: Codable {
    let username: String
    let tag: Int64
    let language: String
    let token: String
    let refresherToken: String
}
