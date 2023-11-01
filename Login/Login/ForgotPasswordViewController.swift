//
//  ForgotPasswordViewController.swift
//  Login
//
//  Created by Matheus Valbert on 29/08/23.
//

import UIKit
import UIComponents

public protocol ForgotPasswordViewControllerDelegate: AnyObject {
    func goBack()
}

public final class ForgotPasswordViewController: CTScrollViewController {
    
    let email = CTTextField(placeholder: "Email", contentType: .emailAddress, returnKeyType: .send, keyboardType: .emailAddress)
    let alert = ErrorAlert.make(title: "Fail send email", message: "Fail to send reset password mail, try again latter.")
    final var forgotPasswordButton: UIBarButtonActivityIndicator?
    
    public var viewModel: LoginViewModel?
    public weak var delegate: ForgotPasswordViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
    }
    
    private func configureViewController() {
        title = "Forgot Password"
        forgotPasswordButton = UIBarButtonActivityIndicator(title: "Send", style: .done, target: self, action: #selector(sendInteractor))
        navigationItem.rightBarButtonItem = forgotPasswordButton
    }
    
    private func configure() {
        contentView.addSubview(email)
        
        email.delegate = self
        
        email.autocapitalizationType = .none
        
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            email.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -1),
            email.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            email.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func forgotPassword() {
        Task {
            startForgotPassword()
            do {
                guard let email = self.email.text else { return }
                try await viewModel?.forgotPassword(email: email)
                delegate?.goBack()
            } catch {
                print(error)
                present(alert, animated: true, completion: nil)
            }
            stopForgotPassword()
        }
    }
    
    private func startForgotPassword() {
        navigationItem.hidesBackButton = true
        email.isEnabled = false
        forgotPasswordButton?.startLoading()
    }
    
    private func stopForgotPassword() {
        navigationItem.hidesBackButton = false
        email.isEnabled = true
        forgotPasswordButton?.stopLoading()
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        forgotPassword()
        return true
    }
}

extension ForgotPasswordViewController {
    
    @objc private func sendInteractor() {
        forgotPassword()
    }
}
