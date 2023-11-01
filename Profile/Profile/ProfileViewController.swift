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
}

public class ProfileViewController: CTScrollViewController {
    
    let refreshControl = UIRefreshControl()
    let profile = CTProfileView()
    
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
        
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profile.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profile.heightAnchor.constraint(equalToConstant: 120),
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
        profile.button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func refreshUser() {
        Task {
            await viewModel?.fetchUserProfileFromServer()
            profile.set(profile: viewModel!.profile!)
            refreshControl.endRefreshing()
        }
    }
    
    @objc private func buttonAction() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                self?.delegate?.openEditProfileModal()
            }
        } else {
            delegate?.openEditProfileModal()
        }
    }
    
    @objc private func closeEditProfileModal() {
        fetchProfile()
    }
}
