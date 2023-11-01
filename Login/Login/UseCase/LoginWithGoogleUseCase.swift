//
//  LoginWithGoogleUseCase.swift
//  Login
//
//  Created by Matheus Valbert on 28/08/23.
//

import Foundation
import DataComponents

public protocol LoginWithGoogleUseCase {
    
    func execute() async throws
}
