//
//  FriendsViewController.swift
//  Chats
//
//  Created by Matheus Valbert on 24/08/23.
//

import UIKit
import UIComponents
import DataComponents

public protocol NewChatViewControllerDelegate: AnyObject {
    func navigateToChatMessages(friend: FriendDomain)
}

public class NewChatViewController: UITableViewController {

    public var viewModel: ChatsViewModel?
    public weak var delegate: NewChatViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure()
    }
    
    private func configureViewController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelView))
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        title = "Friends"
    }
    
    private func configure() {
        tableView.allowsFocus = false
        tableView.rowHeight = 55
        
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
    }
}

extension NewChatViewController {
    
    @objc func cancelView() {
        dismiss(animated: true)
    }
}
