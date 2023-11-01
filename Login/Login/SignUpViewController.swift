//
//  SignUpViewController.swift
//  Login
//
//  Created by Matheus Valbert on 03/08/23.
//

import UIKit
import UIComponents

public protocol SignUpViewControllerDelegate: AnyObject {
    func navigateToApp()
}

public final class SignUpViewController: CTScrollViewController {

    let username = CTTextField(placeholder: "Username", contentType: .username, keyboardType: .asciiCapable)
    let email = CTTextField(placeholder: "Email", contentType: .emailAddress, keyboardType: .emailAddress)
    let password = CTTextField(placeholder: "Password", contentType: .newPassword, returnKeyType: .done)
    let alert = ErrorAlert.make(title: "Fail to sign up", message: "Fail to Sign up, try again latter.")
    
    final var signUpButton: UIBarButtonActivityIndicator?
    
    public var viewModel: LoginViewModel?
    public weak var delegate: SignUpViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
    }
    
    private func configureViewController() {
        title = "Sign Up"
        signUpButton = UIBarButtonActivityIndicator(title: "Sign Up", style: .done, target: self, action: #selector(signUpSelector))
        navigationItem.rightBarButtonItem = signUpButton
    }
    
    private func configure() {
        contentView.addSubview(username)
        contentView.addSubview(email)
        contentView.addSubview(password)
        
        username.delegate = self
        email.delegate = self
        password.delegate = self
        
        email.autocapitalizationType = .none
        password.autocapitalizationType = .none
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            username.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -1),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            username.heightAnchor.constraint(equalToConstant: 40),
            
            email.topAnchor.constraint(equalTo: username.bottomAnchor, constant: -1),
            email.leadingAnchor.constraint(equalTo: username.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: username.trailingAnchor),
            email.heightAnchor.constraint(equalToConstant: 40),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: -1),
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func signUp() {
        Task {
            startSignUp()
            guard let username = self.username.text, let email = self.email.text, let password = self.password.text else { return }
            if await viewModel?.signUp(username: username, email: email, password: password) == true {
                delegate?.navigateToApp()
            } else {
                present(alert, animated: true, completion: nil)
            }
            stopSignUp()
        }
    }
    
    private func startSignUp() {
        navigationItem.hidesBackButton = true
        username.isEnabled = false
        email.isEnabled = false
        password.isEnabled = false
        signUpButton?.startLoading()
    }
    
    private func stopSignUp() {
        navigationItem.hidesBackButton = false
        username.isEnabled = true
        email.isEnabled = true
        password.isEnabled = true
        signUpButton?.stopLoading()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case username:
            email.becomeFirstResponder()
        case email:
            password.becomeFirstResponder()
        case password:
            textField.resignFirstResponder()
            signUp()
        default:
            break
        }
        return true
    }
}

extension SignUpViewController {
    @objc private func signUpSelector() {
        signUp()
    }
}
