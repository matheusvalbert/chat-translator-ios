//
//  ChatsCoordinator.swift
//  ChatTranslator
//
//  Created by Matheus Valbert on 02/08/23.
//

import UIKit
import Login
import Chats

final class LoginCoordinator: Coordinator {
        
    var childCoordinators: [Coordinator] = []
        
    unowned let navigationController: UINavigationController
        
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController()
        vc.viewModel = DIContainer.shared.resolve()
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate, SignUpViewControllerDelegate, SignInViewControllerDelegate {
    
    func navigationBarVisibility(isVisible: Bool) {
        navigationController.setNavigationBarHidden(!isVisible, animated: true)
    }
    
    func navigateToSignUp() {
        let signUpVC = SignUpViewController()
        signUpVC.viewModel = DIContainer.shared.resolve()
        signUpVC.delegate = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func navigateToSignIn() {
        let signInVC = SignInViewController()
        signInVC.viewModel = DIContainer.shared.resolve()
        signInVC.delegate = self
        navigationController.pushViewController(signInVC, animated: true)
    }
    
    func navigateToApp() {
        let appCoordinator: AppCoordinator = DIContainer.shared.resolve()
        appCoordinator.start()
    }
    
    func navigateToForgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController()
        forgotPasswordVC.viewModel = DIContainer.shared.resolve()
        forgotPasswordVC.delegate = self
        navigationController.pushViewController(forgotPasswordVC, animated: true)
    }
}

extension LoginCoordinator: ForgotPasswordViewControllerDelegate {
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
