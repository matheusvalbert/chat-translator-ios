//
//  FetchUserProfileFromServerUseCase.swift
//  Profile
//
//  Created by Matheus Valbert on 08/09/23.
//

import Foundation

import DataComponents

protocol FetchUserProfileFromServerUseCase {

    func execute() async throws -> UserDomain
}
