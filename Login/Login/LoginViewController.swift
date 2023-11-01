//
//  LoginViewController.swift
//  Login
//
//  Created by Matheus Valbert on 03/08/23.
//

import UIKit
import UIComponents
import DataComponents

public protocol LoginViewControllerDelegate: AnyObject {
    func navigationBarVisibility(isVisible: Bool)
    func navigateToSignUp()
    func navigateToSignIn()
    func navigateToApp()
}

public final class LoginViewController: UIViewController {
    
    let logo = CTLogoView()
    let loginWithGoogle = CTButton(title: "", image: Images.google)
    let signIn = CTButton(title: "Sign In", image: nil, style: .tinted())
    let signUp = CTButton(title: "Sign Up")
    let alert = ErrorAlert.make(title: "Fail to Login", message: "Fail to login with google, try again latter.")
    
    public var viewModel: LoginViewModel?
    public weak var delegate: LoginViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.lightPurple
        configure()
        actions()
        viewModel?.configureId()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.navigationBarVisibility(isVisible: false)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.navigationBarVisibility(isVisible: true)
    }
    
    private func configure() {
        view.addSubview(logo)
        view.addSubview(loginWithGoogle)
        view.addSubview(signIn)
        view.addSubview(signUp)
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 300),
            logo.heightAnchor.constraint(lessThanOrEqualToConstant: 210),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginWithGoogle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            loginWithGoogle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWithGoogle.heightAnchor.constraint(equalToConstant: 75),
            loginWithGoogle.widthAnchor.constraint(equalToConstant: 75),
            
            signIn.bottomAnchor.constraint(equalTo: loginWithGoogle.topAnchor, constant: -15),
            signIn.leadingAnchor.constraint(equalTo: logo.leadingAnchor),
            signIn.trailingAnchor.constraint(equalTo: logo.trailingAnchor),
            
            signUp.bottomAnchor.constraint(equalTo: signIn.topAnchor, constant: -10),
            signUp.leadingAnchor.constraint(equalTo: signIn.leadingAnchor),
            signUp.trailingAnchor.constraint(equalTo: signIn.trailingAnchor),
        ])
    }
}

extension LoginViewController {
    private func actions() {
        loginWithGoogle.addTarget(self, action: #selector(loginWithGoogleSelector), for: .touchUpInside)
        signUp.addTarget(self, action: #selector(signUpSelector), for: .touchUpInside)
        signIn.addTarget(self, action: #selector(signInSelector), for: .touchUpInside)
    }
    
    @objc private func signUpSelector() {
        delegate?.navigateToSignUp()
    }
    
    @objc private func signInSelector() {
        delegate?.navigateToSignIn()
    }
    
    @objc private func loginWithGoogleSelector() {
        Task {
            startLoginWithGoogle()
            do {
                try await viewModel?.loginWithGoogle()
                delegate?.navigateToApp()
            } catch {
                print(error)
                present(alert, animated: true, completion: nil)
            }
            stopLoginWithGoogle()
        }
    }
    
    private func startLoginWithGoogle() {
        signIn.disable()
        signUp.disable()
        loginWithGoogle.disable()
        loginWithGoogle.startLoading()
    }
    
    private func stopLoginWithGoogle() {
        signIn.enable()
        signUp.enable()
        loginWithGoogle.enable()
        loginWithGoogle.stopLoading()
    }
}
