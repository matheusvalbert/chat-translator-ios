//
//  FriendsViewController.swift
//  Friend
//
//  Created by Matheus Valbert on 18/08/23.
//

import UIKit
import UIComponents
import DataComponents

public protocol FriendsViewControllerDelegate: AnyObject {
    func navigateToFriendRequest()
    func navigateToChatMessages(friend: FriendDomain)
    func navigateToAddFriends()
}

public class FriendsViewController: UITableViewController {
    
    let alert = ErrorAlert.make(title: "Pending response", message: "Waiting for your friend to accept or decline your friend request")
    
    public var viewModel: FriendViewModel?
    public weak var delegate: FriendsViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureRefreshControll()
        configureModal()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
        fetchFriends()
    }
    
    private func configureViewController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFriendSelector))
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Friends"
    }
    
    private func configure() {
        tableView.allowsFocus = false
        tableView.rowHeight = 55
        
        tableView.register(RequestFriendsCell.self, forCellReuseIdentifier: RequestFriendsCell.reuseID)
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
    }
    
    private func configureRefreshControll() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFriends), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    private func configureModal() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshFriends), name: NSNotification.Name("ModalDisposed"), object: nil)
    }
    
    private func fetchFriends() {
        Task {
            await viewModel?.fetch()
            tableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FriendsViewController {
    
    @objc private func addNewFriendSelector() {
        delegate?.navigateToAddFriends()
    }
    
    @objc private func refreshFriends() {
        Task {
            await viewModel?.reload()
            tableView.reloadData()
            refreshControl?.endRefreshing()
        }
    }
}
