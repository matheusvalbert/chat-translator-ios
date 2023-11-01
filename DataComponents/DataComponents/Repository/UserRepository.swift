//
//  UserRepository.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation

public protocol UserRepository {
    
    func login(token: String) async throws -> UserDomain
    
    func exits() async throws -> Bool
    
    func fetch() async throws -> UserDomain
    
    func reloadUserData() async throws
    
    func update(username: String, language: Languages) async throws
    
    func updateToken() async throws
    
    func insert(username: String, tag: Int64, language: Languages) async throws
    
    func insert(token: String)
}
