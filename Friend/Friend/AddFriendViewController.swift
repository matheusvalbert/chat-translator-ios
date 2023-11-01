//
//  AddFriendsViewController.swift
//  Friend
//
//  Created by Matheus Valbert on 24/08/23.
//

import UIKit
import UIComponents

public class AddFriendViewController: CTScrollViewController {

    let user = CTTextField(placeholder: "JohnDoe#1", contentType: .username, returnKeyType: .done, keyboardType: .asciiCapable)
    let alert = ErrorAlert.make(title: "Fail to send friend request", message: "Fail to send friend request, try again latter.")
    
    final var cancelButton: UIBarButtonItem?
    final var doneButton: UIBarButtonActivityIndicator?
    
    public var viewModel: FriendViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
    }
    
    private func configureViewController() {
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelView))
        doneButton = UIBarButtonActivityIndicator(barButtonSystemItem: .done, target: self, action: #selector(doneView))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        title = "Add Friend"
    }
    
    private func configure() {
        contentView.addSubview(user)
        
        user.delegate = self
        
        NSLayoutConstraint.activate([
            user.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            user.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -1),
            user.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            user.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func addNewFriend() {
        guard let user = self.user.text else { return }
        
        Task {
            startLoading()
            let request = await viewModel?.request(user: user)
            stopLoading()
            if request == true {
                self.user.resignFirstResponder()
                dismiss(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name("ModalDisposed"), object: nil)
            } else {
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func startLoading() {
        isModalInPresentation = true
        user.isEnabled = false
        cancelButton?.isEnabled = false
        doneButton?.startLoading()
    }
    
    private func stopLoading() {
        isModalInPresentation = false
        user.isEnabled = true
        cancelButton?.isEnabled = true
        doneButton?.stopLoading()
    }
}

extension AddFriendViewController {
    
    @objc private func cancelView() {
        dismiss(animated: true)
    }
    
    @objc private func doneView() {
        addNewFriend()
    }
}

extension AddFriendViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNewFriend()
        return true
    }
}
