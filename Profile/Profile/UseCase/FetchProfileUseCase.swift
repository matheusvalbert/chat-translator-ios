//
//  FetchProfileUseCase.swift
//  Profile
//
//  Created by Matheus Valbert on 01/09/23.
//

import Foundation
import DataComponents

protocol FetchProfileUseCase {

    func execute() async throws -> UserDomain
}
