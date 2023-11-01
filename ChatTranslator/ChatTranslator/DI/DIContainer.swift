//
//  DIContainer.swift
//  ChatTranslator
//
//  Created by Matheus Valbert on 28/08/23.
//

import Foundation
import Swinject
import DataComponents
import Login
import Profile
import Friend
import Chats

final class DIContainer {
    
    static let shared = DIContainer()

    let container: Container = Container()
    let assembler: Assembler

    init() {
        assembler = Assembler([
            CoordinatorAssembly(),
            RepositoryAssembly(),
            EventAssembly(),
            NetworkAssembly(),
            AppDatabaseAssembly(),
            MessagingAssembly(),
            UseCaseAssembly(),
            LoginAssembly(),
            ProfileAssembly(),
            FriendAssembly(),
            ChatsAssembly(),
        ], container: container)
    }

    func resolve<T>() -> T {
        guard let resolvedType = container.resolve(T.self) else {
            fatalError()
        }
        return resolvedType
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let resolvedType = container.resolve(type) else {
            fatalError()
        }
        
        return resolvedType
    }
}
