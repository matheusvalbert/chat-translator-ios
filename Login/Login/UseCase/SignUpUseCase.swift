//
//  SignUpUseCase.swift
//  Login
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation
import DataComponents

public protocol SignUpUseCase {
    
    func execute(username: String, email: String, password: String) async throws
}
