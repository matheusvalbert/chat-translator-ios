//
//  SignInViewController.swift
//  Login
//
//  Created by Matheus Valbert on 03/08/23.
//

import UIKit
import UIComponents

public protocol SignInViewControllerDelegate: AnyObject {
    func navigateToApp()
    func navigateToForgotPassword()
}

public final class SignInViewController: CTScrollViewController {
    
    let email = CTTextField(placeholder: "Email", contentType: .emailAddress, keyboardType: .emailAddress)
    let password = CTTextField(placeholder: "Password", contentType: .password, isPassword: true, returnKeyType: .done)
    let forgotPassword = CTButton(title: "Forgot Password?", style: .borderless())
    let alert = ErrorAlert.make(title: "Fail to sign in", message: "Fail to sign in, try again latter.")
    final var signInButton: UIBarButtonActivityIndicator?
    
    public var viewModel: LoginViewModel?
    public weak var delegate: SignInViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
    }
    
    private func configureViewController() {
        title = "Sign In"
        signInButton = UIBarButtonActivityIndicator(title: "Sign In", style: .done, target: self, action: #selector(signInSelector))
        navigationItem.rightBarButtonItem = signInButton
    }
    
    private func configure() {
        contentView.addSubview(email)
        contentView.addSubview(password)
        contentView.addSubview(forgotPassword)
        
        email.delegate = self
        password.delegate = self
        
        forgotPassword.addTarget(self, action: #selector(forgotPasswordSelector), for: .touchUpInside)
        
        email.autocapitalizationType = .none
        password.autocapitalizationType = .none
        
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            email.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -1),
            email.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            email.heightAnchor.constraint(equalToConstant: 40),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: -1),
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10),
            forgotPassword.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func signIn() async {
        do {
            guard let email = self.email.text, let password = self.password.text else { return }
            try await viewModel?.signIn(email: email, password: password)
            delegate?.navigateToApp()
        } catch {
            print(error)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case email:
            password.becomeFirstResponder()
        case password:
            textField.resignFirstResponder()
            signInSelector()
        default:
            break
        }
        return true
    }
}

extension SignInViewController {
    
    @objc private func signInSelector() {
        Task {
            startSignIn()
            await signIn()
            stopSignIn()
        }
    }
    
    private func startSignIn() {
        email.isEnabled = false
        password.isEnabled = false
        navigationItem.hidesBackButton = true
        forgotPassword.isEnabled = false
        signInButton?.startLoading()
    }
    
    private func stopSignIn() {
        email.isEnabled = true
        password.isEnabled = true
        signInButton?.stopLoading()
        forgotPassword.isEnabled = true
        navigationItem.hidesBackButton = false
    }
    
    @objc private func forgotPasswordSelector() {
        delegate?.navigateToForgotPassword()
    }
}
