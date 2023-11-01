//
//  LoginAssembly.swift
//  Login
//
//  Created by Matheus Valbert on 28/08/23.
//

import Foundation
import Swinject
import DataComponents

public final class LoginAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(ConfigureGoogleIdUseCase.self) { resolver in
            guard let firebaseRepository = resolver.resolve(FirebaseRepository.self) else {
                fatalError("firebase repository dependency could not be resolved")
            }
            
            return ConfigureGoogleIdUseCaseImpl(firebaseRepository: firebaseRepository)
        }
        
        container.register(LoginWithGoogleUseCase.self) { resolver in
            guard let firebaseRepository = resolver.resolve(FirebaseRepository.self) else {
                fatalError("firebase repository dependency could not be resolved")
            }
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            return LoginWithGoogleUseCaseImpl(firebaseRepository: firebaseRepository, userRepository: userRepository, friendRepository: friendRepository)
        }
        
        container.register(SignUpUseCase.self) { resolver in
            guard let firebaseRepository = resolver.resolve(FirebaseRepository.self) else {
                fatalError("firebase repository dependency could not be resolved")
            }
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            return SignUpUseCaseImpl(firebaseRepository: firebaseRepository, userRepository: userRepository, friendRepository: friendRepository)
        }
        
        container.register(SignInUseCase.self) { resolver in
            guard let firebaseRepository = resolver.resolve(FirebaseRepository.self) else {
                fatalError("firebase repository dependency could not be resolved")
            }
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            guard let friendRepository = resolver.resolve(FriendRepository.self) else {
                fatalError("friend repository dependency could not be resolved")
            }
            
            return SignInUseCaseImpl(firebaseRepository: firebaseRepository, userRepository: userRepository, friendRepository: friendRepository)
        }
        
        container.register(ForgotPasswordUseCase.self) { resolver in
            guard let firebaseRepository = resolver.resolve(FirebaseRepository.self) else {
                fatalError("firebase repository dependency could not be resolved")
            }
            
            return ForgotPasswordUseCaseImpl(firebaseRepository: firebaseRepository)
        }
        
        container.register(LoginViewModel.self) { resolver in
            guard let configureGoogleIdUseCase = resolver.resolve(ConfigureGoogleIdUseCase.self) else {
                fatalError("configure google id use case dependency could not be resolved")
            }
            
            guard let loginWithGoogleUseCase = resolver.resolve(LoginWithGoogleUseCase.self) else {
                fatalError("configure google id use case dependency could not be resolved")
            }
            
            guard let signUpUseCase = resolver.resolve(SignUpUseCase.self) else {
                fatalError("sign up use case dependency could not be resolved")
            }
            
            guard let signInUseCase = resolver.resolve(SignInUseCase.self) else {
                fatalError("sign in use case dependency could not be resolved")
            }
            
            guard let forgotPasswordUseCase = resolver.resolve(ForgotPasswordUseCase.self) else {
                fatalError("configure google id use case dependency could not be resolved")
            }
            
            return LoginViewModel(
                configureGoogleIdUseCase: configureGoogleIdUseCase,
                loginWithGoogleUseCase: loginWithGoogleUseCase,
                signUpUseCase: signUpUseCase,
                signInUseCase: signInUseCase,
                forgotPasswordUseCase: forgotPasswordUseCase
            )
        }
    }
}
