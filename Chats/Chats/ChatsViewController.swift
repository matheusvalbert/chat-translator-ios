//
//  ChatsViewController.swift
//  Chats
//
//  Created by Matheus Valbert on 04/08/23.
//

import UIKit
import Combine
import UIComponents
import DataComponents

public protocol ChatsViewControllerDelegate: AnyObject {
    func navigateToChatMessages(friend: FriendDomain)
    func navigateToNewChat()
}

public class ChatsViewController: UITableViewController {
    
    public var viewModel: ChatsViewModel?
    public var delegate: ChatsViewControllerDelegate?
    
    private var cancellables: Set<AnyCancellable> = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        configure()
        
        viewModel?.$chats.sink { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
        fetchChats()
    }
    
    private func configureViewController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newChatSelector))
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.scrollEdgeAppearance = nil
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Chats"
    }
    
    private func configure() {
        tableView.rowHeight = 80
        tableView.register(ChatsViewCell.self, forCellReuseIdentifier: ChatsViewCell.reuseID)
    }
    
    private func fetchChats() {
        Task {
            await viewModel?.fetchChats()
        }
    }
    
    deinit { 
        delegate = nil
        cancellables.forEach { $0.cancel() }
    }
}

extension ChatsViewController {
    
    @objc private func newChatSelector() {
        delegate?.navigateToNewChat()
    }
}
