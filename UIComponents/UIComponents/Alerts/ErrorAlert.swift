//
//  ErrorAlert.swift
//  UIComponents
//
//  Created by Matheus Valbert on 13/09/23.
//

import UIKit

public class ErrorAlert: UIAlertController {
    
    public static func make(title: String, message: String) -> ErrorAlert {
        let alert = ErrorAlert(title: title, message: message, preferredStyle: .alert)
        alert.configureAction()
        return alert
    }
    
    private func configureAction() {
        let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive)
        addAction(dismissAction)
    }
}
