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
    let loginWithApple = CTButton(title: "", image: Icons.apple)
    let loginWithView = UIStackView()
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
        configureLoginWithView()
        
        view.addSubview(logo)
        view.addSubview(loginWithView)
        view.addSubview(signIn)
        view.addSubview(signUp)
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 300),
            logo.heightAnchor.constraint(lessThanOrEqualToConstant: 210),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginWithView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            loginWithView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signIn.bottomAnchor.constraint(equalTo: loginWithGoogle.topAnchor, constant: -15),
            signIn.leadingAnchor.constraint(equalTo: logo.leadingAnchor),
            signIn.trailingAnchor.constraint(equalTo: logo.trailingAnchor),
            
            signUp.bottomAnchor.constraint(equalTo: signIn.topAnchor, constant: -10),
            signUp.leadingAnchor.constraint(equalTo: signIn.leadingAnchor),
            signUp.trailingAnchor.constraint(equalTo: signIn.trailingAnchor),
        ])
    }
    
    private func configureLoginWithView() {
        loginWithView.axis = .horizontal
        loginWithView.spacing = 10
        loginWithView.alignment = .center
        
        loginWithView.addArrangedSubview(loginWithGoogle)
        loginWithView.addArrangedSubview(loginWithApple)
        
        NSLayoutConstraint.activate([
            loginWithGoogle.heightAnchor.constraint(equalToConstant: 75),
            loginWithGoogle.widthAnchor.constraint(equalToConstant: 75),
            
            loginWithApple.heightAnchor.constraint(equalToConstant: 75),
            loginWithApple.widthAnchor.constraint(equalToConstant: 75),
        ])
        
        loginWithView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension LoginViewController {
    private func actions() {
        loginWithGoogle.addTarget(self, action: #selector(loginWithGoogleSelector), for: .touchUpInside)
        loginWithApple.addTarget(self, action: #selector(loginWithAppleSelector), for: .touchUpInside)
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
            startLogin(with: .google)
            do {
                try await viewModel?.loginWithGoogle()
                delegate?.navigateToApp()
            } catch {
                print(error)
                present(alert, animated: true, completion: nil)
            }
            stopLogin(with: .google)
        }
    }
    
    @objc private func loginWithAppleSelector() {
        Task {
            startLogin(with: .apple)
            do {
                try await viewModel?.loginWithApple()
                delegate?.navigateToApp()
            } catch {
                print(error)
                present(alert, animated: true, completion: nil)
            }
            stopLogin(with: .apple)
        }
    }
    
    private enum LoaderType {
        case google, apple
    }
    
    private func startLogin(with loginType: LoaderType) {
        signIn.disable()
        signUp.disable()
        loginWithGoogle.disable()
        loginWithApple.disable()
        if loginType == .google {
            loginWithGoogle.startLoading()
        } else if loginType == .apple {
            loginWithApple.startLoading()
        }
    }
    
    private func stopLogin(with loginType: LoaderType) {
        signIn.enable()
        signUp.enable()
        loginWithGoogle.enable()
        loginWithApple.enable()
        if loginType == .google {
            loginWithGoogle.stopLoading()
        } else if loginType == .apple {
            loginWithApple.stopLoading()
        }
    }
}
