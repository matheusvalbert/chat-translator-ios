//
//  CoordinatorAssembly.swift
//  ChatTranslator
//
//  Created by Matheus Valbert on 31/10/23.
//

import Foundation
import Swinject
import DataComponents

public final class CoordinatorAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Swinject.Container) {
        
        container.register(UINavigationController.self) { resolver in
            
            return UINavigationController()
        }.inObjectScope(.container)
        
        container.register(LoginCoordinator.self) { resolver in
            
            guard let navigationController = resolver.resolve(UINavigationController.self) else {
                fatalError("navigation controller dependency could not be resolved")
            }
            
            return LoginCoordinator(navigationController: navigationController)
        }.inObjectScope(.container)
        
        container.register(AppCoordinator.self) { resolver in
            
            guard let navigationController = resolver.resolve(UINavigationController.self) else {
                fatalError("navigation controller dependency could not be resolved")
            }
            
            return AppCoordinator(navigationController: navigationController)
        }.inObjectScope(.container)
        
        container.register(ExposedCoordinator.self) { resolver in
            
            guard let appCoordinator = resolver.resolve(AppCoordinator.self) else {
                fatalError("app coordinator dependency could not be resolved")
            }
            
            return appCoordinator
        }
    }
}
