//
//  Renew.swift
//  DataComponents
//
//  Created by Matheus Valbert on 04/09/23.
//

import Foundation

struct RenewResponse: Codable {
    let token: String
    let refresherToken: String
}
