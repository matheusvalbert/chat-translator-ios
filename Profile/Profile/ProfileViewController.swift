//
//  ProfileViewController.swift
//  Profile
//
//  Created by Matheus Valbert on 07/08/23.
//

import UIKit
import UIComponents

public protocol ProfileViewControllerDelegate: AnyObject {
    func openEditProfileModal()
    func backToLogin()
}

public class ProfileViewController: CTScrollViewController {
    
    let refreshControl = UIRefreshControl()
    let profile = CTProfileView()
    let deleteAccount = CTButton(title: "Delete account", style: .plain(), customTextColor: .systemRed)
    let deleteAccountAlert = DeleteAccountAlert.make()
    var loadingView: CTDataLoadingViewController?
    
    public var viewModel: ProfileViewModel?
    public weak var delegate: ProfileViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
        configureModal()
        actions()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProfile()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        refreshControl.endRefreshing()
    }
    
    private func configureViewController() {
        title = "Profile"
        refreshControl.addTarget(self, action: #selector(refreshUser), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    private func configure() {
        contentView.addSubview(profile)
        contentView.addSubview(deleteAccount)
        
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profile.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profile.heightAnchor.constraint(equalToConstant: 120),
            
            deleteAccount.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 10),
            deleteAccount.leadingAnchor.constraint(equalTo: profile.leadingAnchor),
            deleteAccount.trailingAnchor.constraint(equalTo: profile.trailingAnchor),
            deleteAccount.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    private func configureModal() {
        NotificationCenter.default.addObserver(self, selector: #selector(closeEditProfileModal), name: NSNotification.Name("ModalDisposed"), object: nil)
    }
    
    private func fetchProfile() {
        Task {
            await viewModel?.fetchProfile()
            profile.set(profile: viewModel!.profile!)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ProfileViewController {
    private func actions() {
        profile.button.addTarget(self, action: #selector(profileButtonAction), for: .touchUpInside)
        deleteAccount.addTarget(self, action: #selector(deleteAccountButtonAction), for: .touchUpInside)
    }
    
    @objc private func refreshUser() {
        Task {
            await viewModel?.fetchUserProfileFromServer()
            profile.set(profile: viewModel!.profile!)
            refreshControl.endRefreshing()
        }
    }
    
    @objc private func profileButtonAction() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                self?.delegate?.openEditProfileModal()
            }
        } else {
            delegate?.openEditProfileModal()
        }
    }
    
    @objc private func deleteAccountButtonAction() {
        
        present(deleteAccountAlert, animated: true, completion: nil)
        
        deleteAccountAlert.deleteAccount = {
            Task {
                self.startLoading()
                await self.viewModel?.deleteAccount()
                self.stopLoading()
                self.delegate?.backToLogin()
            }
        }
    }
    
    private func startLoading() {
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.layoutIfNeeded()
        scrollView.removeFromSuperview()
        loadingView = CTDataLoadingViewController(frame: view.bounds)
        view.addSubview(loadingView!)
    }
    
    private func stopLoading() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        loadingView?.removeFromSuperview()
        self.view.layoutIfNeeded()
        super.viewDidLoad()
    }
    
    @objc private func closeEditProfileModal() {
        fetchProfile()
    }
}
