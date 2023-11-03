//
//  DeleteAccountAlert.swift
//  UIComponents
//
//  Created by Matheus Valbert on 03/11/23.
//

import UIKit

public class DeleteAccountAlert: UIAlertController {
    
    public var deleteAccount: (() -> Void)? = nil
    
    public static func make() -> DeleteAccountAlert {
        let alert = DeleteAccountAlert(title: "Delete Account", message: "This action will delete all your data. this can't be undone.", preferredStyle: .actionSheet)
        alert.configureActions()
        return alert
    }
    
    private func configureActions() {
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        addAction(cancel)
        let delete = UIAlertAction(title: "Delete Account", style: .destructive) { action in
            self.deleteAccount?()
        }
        addAction(delete)
    }
}
