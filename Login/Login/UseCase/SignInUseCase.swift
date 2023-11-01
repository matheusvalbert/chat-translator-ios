//
//  SignInUseCase.swift
//  Login
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation
import DataComponents

public protocol SignInUseCase {
    
    func execute(email: String, password: String) async throws
}
