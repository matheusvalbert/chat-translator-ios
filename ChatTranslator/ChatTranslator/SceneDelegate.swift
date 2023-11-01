//
//  SceneDelegate.swift
//  ChatTranslator
//
//  Created by Matheus Valbert on 30/07/23.
//

import UIKit
import Swinject
import DataComponents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: Coordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController: UINavigationController = DIContainer.shared.resolve()
        
        let userRepository: UserRepository = DIContainer.shared.resolve()
        Task {
            do {
                let exists = try await userRepository.exits()
                if exists {
                    coordinator = DIContainer.shared.resolve(AppCoordinator.self)
                } else {
                    coordinator = DIContainer.shared.resolve(LoginCoordinator.self)
                }
                coordinator?.start()
            } catch {
                print(error)
            }
        }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        let db: AppDatabase = DIContainer.shared.resolve()
        db.saveContext()
    }
}
