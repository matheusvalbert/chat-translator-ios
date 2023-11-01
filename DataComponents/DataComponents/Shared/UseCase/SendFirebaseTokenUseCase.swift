//
//  SendFirebaseTokenUseCase.swift
//  DataComponents
//
//  Created by Matheus Valbert on 23/10/23.
//

import Foundation

public protocol SendFirebaseTokenUseCase {

    func execute(token: String) async throws
}
