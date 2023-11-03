//
//  UserRepositoryImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    
    private let userService: UserService
    private let userDao: UserDao
    
    init(userService: UserService, userDao: UserDao) {
        self.userService = userService
        self.userDao = userDao
    }
    
    func login(token: String) async throws -> UserDomain {
        let user = try await userService.login(token: token)
        return UserDomain(username: user.username, tag: user.tag, language: Languages(rawValue: user.language)!, token: user.token, refresherToken: user.refresherToken)
    }
    
    func exits() async throws -> Bool {
        return try await userDao.exists()
    }
    
    func fetch() async throws -> UserDomain {
        let user = try await userDao.fetch()
        return UserDomain(username: user.username, tag: user.tag, language: Languages(rawValue: user.language)!)
    }
    
    func reloadUserData() async throws {
        let user = try await userService.fetch()
        try await userDao.update(username: user.username, language: user.language)
    }
    
    func update(username: String, language: Languages) async throws {
        try await userService.update(data: UpdateRequest(username: username, language: language.rawValue))
        try await userDao.update(username: username, language: language.rawValue)
    }
    
    func updateToken() async throws {
        if !FirebaseToken.wasSent() {
            try await userService.update(token: UpdateTokenRequest(fbToken: FirebaseToken.fetch()))
            FirebaseToken.update(sent: true)
        }
    }
    
    func insert(username: String, tag: Int64, language: Languages) async throws {
        try await userDao.insert(username: username, tag: tag, language: language.rawValue)
    }
    
    func insert(token: String) {
        if !FirebaseToken.isValid(token: token) {
            FirebaseToken.update(token: token)
        }
    }
    
    func delete() async throws {
        try await userService.delete()
        try await userDao.delete()
    }
}
