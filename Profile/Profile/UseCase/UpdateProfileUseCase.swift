//
//  UpdateProfileUseCase.swift
//  Profile
//
//  Created by Matheus Valbert on 06/09/23.
//

import Foundation
import DataComponents

protocol UpdateProfileUseCase {
    
    func execute(username: String, language: Languages) async throws
}
