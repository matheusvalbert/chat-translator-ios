//
//  FirebaseError.swift
//  DataComponents
//
//  Created by Matheus Valbert on 28/08/23.
//

import Foundation

public enum FirebaseError: String, Error {
    case recoveryUIViewControllerError = "Error to recovery main UIViewController"
    case loginWithGoogleCredentialError = "Error to get credential login with google"
    case fetchTokenError = "Error to fetch token from google"
}
