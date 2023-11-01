//
//  FriendRequestViewController.swift
//  Friend
//
//  Created by Matheus Valbert on 23/08/23.
//

import UIKit
import UIComponents
import DataComponents

public class FriendRequestViewController: CTScrollViewController {
    
    let image = CTImageView(image: Icons.profile(icon: "t", size: .large))
    let user = CTLabel(text: "Test#1", numberOfLines: 1, font: .title1)
    let decline = CTButton(title: "Decline", style: .tinted(), activityIndicatorStyle: .medium)
    let accept = CTButton(title: "Accept", activityIndicatorStyle: .medium)
    
    final var doneButton: UIBarButtonItem?
    
    let alert = ErrorAlert.make(title: "Fail to response", message: "Fail to send friend response, try again latter.")
    
    public var viewModel: FriendViewModel?

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
        configureUserData()
    }
    
    private func configureViewController() {
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneView))
        navigationItem.rightBarButtonItem = doneButton
        decline.addTarget(self, action: #selector(declineSelector), for: .touchUpInside)
        accept.addTarget(self, action: #selector(acceptSelector), for: .touchUpInside)
        title = "Friend Request"
    }
    
    private func configure() {
        contentView.addSubview(image)
        contentView.addSubview(user)
        contentView.addSubview(decline)
        contentView.addSubview(accept)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 175),
            image.widthAnchor.constraint(equalToConstant: 175),
            
            user.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            user.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            decline.topAnchor.constraint(equalTo: user.bottomAnchor, constant: 45),
            decline.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: -50),
            decline.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -10),
            
            
            accept.topAnchor.constraint(equalTo: decline.topAnchor),
            accept.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: 50),
            accept.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
        ])
    }
    
    private func configureUserData() {
        let user = viewModel?.friends[(viewModel?.selectedIndex)!]
        image.set(image: Icons.profile(icon: user!.username, size: .small))
        self.user.set(text: user!.username + "#" + String(user!.tag))
    }
}

extension FriendRequestViewController {
    
    @objc private func doneView() {
        dismiss(animated: true)
    }
    
    @objc private func declineSelector() {
        Task {
            let user = viewModel?.friends[(viewModel?.selectedIndex)!]
            startLoading(type: .declined)
            let response = await viewModel?.response(tag: user!.tag, status: .declined)
            stopLoading()
            handleResponse(response)
        }
    }
    
    @objc private func acceptSelector() {
        Task {
            let user = viewModel?.friends[(viewModel?.selectedIndex)!]
            startLoading(type: .accepted)
            let response = await viewModel?.response(tag: user!.tag, status: .accepted)
            stopLoading()
            handleResponse(response)
        }
    }
    
    private func handleResponse(_ response: Bool?) {
        if response == true {
            NotificationCenter.default.post(name: NSNotification.Name("ModalDisposed"), object: nil)
            dismiss(animated: true)
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func startLoading(type: FriendStatus) {
        isModalInPresentation = true
        doneButton?.isEnabled = false
        decline.isEnabled = false
        accept.isEnabled = false
        if type == .declined {
            decline.startLoading()
        } else if type == .accepted {
            accept.startLoading()
        }
    }
    
    private func stopLoading() {
        isModalInPresentation = false
        doneButton?.isEnabled = true
        decline.isEnabled = true
        accept.isEnabled = true
        decline.stopLoading()
        accept.stopLoading()
    }
}
