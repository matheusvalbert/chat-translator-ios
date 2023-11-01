//
//  ForgotPasswordUseCase.swift
//  Login
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation
import DataComponents

public protocol ForgotPasswordUseCase {
    
    func execute(email: String) async throws
}
