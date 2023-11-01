//
//  SendMessageUseCase.swift
//  DataComponents
//
//  Created by Matheus Valbert on 24/10/23.
//

import Foundation

public protocol SendMessageUseCase {

    func execute(tag: Int64, message: String) async throws
}
