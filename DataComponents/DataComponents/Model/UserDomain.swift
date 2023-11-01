//
//  UserDomain.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation

public struct UserDomain {
    public var username: String
    public var tag: Int64
    public var language: Languages
    public var token: String?
    public var refresherToken: String?
}
