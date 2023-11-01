//
//  ProfileAssembly.swift
//  Profile
//
//  Created by Matheus Valbert on 01/09/23.
//

import Foundation
import Swinject
import DataComponents

public final class ProfileAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(FetchProfileUseCase.self) { resolver in
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            return FetchProfileUseCaseImpl(userRepository: userRepository)
        }
        
        container.register(FetchUserProfileFromServerUseCase.self) { resolver in
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            return FetchUserProfileFromServerUseCaseImpl(userRepository: userRepository)
        }
        
        container.register(UpdateProfileUseCase.self) { resolver in
            
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("user repository dependency could not be resolved")
            }
            
            return UpdateProfileUseCaseImpl(userRepository: userRepository)
        }
        
        container.register(ProfileViewModel.self) { resolver in
            
            guard let fetchProfileUseCase = resolver.resolve(FetchProfileUseCase.self) else {
                fatalError("fetch profile use case dependency could not be resolved")
            }
            
            guard let fetchUserProfileFromServerUseCase = resolver.resolve(FetchUserProfileFromServerUseCase.self) else {
                fatalError("fetch profile use case dependency could not be resolved")
            }
            
            guard let updateProfileUseCase = resolver.resolve(UpdateProfileUseCase.self) else {
                fatalError("update profile use case dependency could not be resolved")
            }
            
            return ProfileViewModel(fetchProfileUseCase: fetchProfileUseCase, updateProfileUseCase: updateProfileUseCase, fetchUserProfileFromServerUseCase: fetchUserProfileFromServerUseCase)
        }.inObjectScope(.container)
    }
}
