//
//  MessagesViewController.swift
//  Chats
//
//  Created by Matheus Valbert on 12/08/23.
//

import UIKit
import Combine

public class MessagesViewController: UIViewController {
    
    public var viewModel: ChatsViewModel?

    let navigationBar = CTNavigationBar()
    
    let tableView = MessagesTableView()
    let messageInput = MessageInputView()
    let bottomView = MessageBottomView()
    
    let messageInputSize: CGFloat = 58
    var keyboardSize: CGFloat = 0
    var keyboardIsActive = false
    
    var messageInputBottomConstraintInitial: NSLayoutConstraint!
    var messageInputBottomConstraintDisappear: NSLayoutConstraint!
    
    private var cancellables: Set<AnyCancellable> = []
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureKeyboard()
        
        viewModel?.$messages.sink { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.scrollToBottom(row: self.viewModel?.messages.count ?? 0)
            }
        }.store(in: &cancellables)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigation()
        messageInputBottomConstraintInitial.isActive = true
        messageInputBottomConstraintDisappear?.isActive = false
        fetchMessages()
    }
    
    private func fetchMessages() {
        Task {
            await viewModel?.fetchMessages()
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if keyboardIsActive == true {
            messageInputBottomConstraintDisappear = self.messageInput.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -self.keyboardSize)
            messageInputBottomConstraintInitial.isActive = false
            messageInputBottomConstraintDisappear.isActive = true
        }
        viewModel?.removeMessages()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.configureBottomInsets(size: messageInput.textSize + messageInput.lineSize + (keyboardIsActive ? (keyboardSize - view.safeAreaInsets.bottom) : 0))
    }
    
    private func configureNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.titleView = navigationBar
        navigationItem.scrollEdgeAppearance = .init()
        navigationBar.set(username: (viewModel?.selectedFriend!.username)! + "#" + String((viewModel?.selectedFriend?.tag)!))
    }
    
    private func configure() {
        
        view.addSubview(tableView)
        view.addSubview(messageInput)
        
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        
        tableView.pinToEdges(of: view)
        
        messageInputBottomConstraintInitial = messageInput.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        
        NSLayoutConstraint.activate([
            messageInput.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInput.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInput.heightAnchor.constraint(equalToConstant: messageInputSize),
            messageInputBottomConstraintInitial,
        ])
        
        bottomView.create(view: view)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        messageInput.text.delegate = self
        
        messageInput.send.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        cancellables.forEach { $0.cancel() }
    }
}

extension MessagesViewController {
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]as? CGRect else { return }
        self.keyboardSize = keyboardSize.height
        tableView.configureBottomInsets(size: messageInput.textSize + messageInput.lineSize - view.safeAreaInsets.bottom + self.keyboardSize)
        tableView.scrollToBottom(row: viewModel?.messages.count ?? 0, animated: true)
        keyboardIsActive = true
        bottomView.remove()
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardIsActive = false
        bottomView.add()
        if messageInput.isEditing == false {
            tableView.configureBottomInsets(size: messageInput.textSize + messageInput.lineSize)
        }
    }
    
    @objc private func sendMessage() {
        guard let message = messageInput.text.text else { return }
        Task {
            await viewModel?.sendMessage(message: message)
        }
        messageInput.text.text = ""
        messageInput.send.isEnabled = false
        textViewDidChange(messageInput.text)
    }
}

extension MessagesViewController: UITextViewDelegate {
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        messageInput.isEditing = true
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        messageInput.isEditing = false
        return true
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        messageInput.send.isEnabled = !textView.text.isEmpty
        messageInput.textSize = textView.contentSize.height
        if messageInput.textSize <= 104 {
            tableView.scrollToBottom(row: viewModel?.messages.count ?? 0, animated: true)
            messageInput.adjustSize()
        }
    }
}
