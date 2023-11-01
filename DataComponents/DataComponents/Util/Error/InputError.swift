//
//  InputError.swift
//  DataComponents
//
//  Created by Matheus Valbert on 29/08/23.
//

import Foundation

public enum InputError: String, Error {
    case invalidUsername = "Error invalid username"
    case invalidEmail = "Error invalid email"
    case invalidPassword = "Error invalid password"
    case invalidUser = "Error invalid username or tag"
}
