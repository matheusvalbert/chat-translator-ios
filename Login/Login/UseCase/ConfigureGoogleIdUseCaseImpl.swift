//
//  ConfigureGoogleIdImpl.swift
//  Login
//
//  Created by Matheus Valbert on 28/08/23.
//

import Foundation
import DataComponents

final class ConfigureGoogleIdUseCaseImpl: ConfigureGoogleIdUseCase {
    
    private let firebaseRepository: FirebaseRepository
    
    init(firebaseRepository: FirebaseRepository) {
        self.firebaseRepository = firebaseRepository
    }
    
    func execute() {
        firebaseRepository.configureId()
    }
}
