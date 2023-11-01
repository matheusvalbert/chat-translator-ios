//
//  ChatViewCell.swift
//  UIComponents
//
//  Created by Matheus Valbert on 04/08/23.
//

import UIKit
import UIComponents

class ChatsViewCell: UITableViewCell {
    
    public static let reuseID = "ChatsCell"
    private let image = CTImageView(image: Icons.profile(icon: "", size: .medium))
    private let username = CTLabel(text: "User", numberOfLines: 1, font: .headline)
    private let message = CTLabel(text: "Message", numberOfLines: 2, font: .body)
    private let numberOfMessages = CircleNumberView()
    
    var userTrailing: NSLayoutConstraint!
    var userTrailingUnreadMessages: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(image)
        contentView.addSubview(username)
        contentView.addSubview(message)
        
        accessoryType = .disclosureIndicator
        
        numberOfMessages.translatesAutoresizingMaskIntoConstraints = false
        
        userTrailing = username.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8)
        userTrailingUnreadMessages = username.trailingAnchor.constraint(equalTo: numberOfMessages.leadingAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            image.widthAnchor.constraint(equalToConstant: 65),
            image.heightAnchor.constraint(equalToConstant: 65),
            
            username.topAnchor.constraint(equalTo: image.topAnchor, constant: 1),
            username.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 24),
            userTrailing,
            username.bottomAnchor.constraint(equalTo: message.topAnchor),
            
            message.topAnchor.constraint(equalTo: username.bottomAnchor),
            message.leadingAnchor.constraint(equalTo: username.leadingAnchor),
            message.trailingAnchor.constraint(equalTo: username.trailingAnchor, constant: -8),
        ])
    }
    
    func set(username: String, message: String, unreadMessages: Int) {
        configureNumberOfMessages(unreadMessages: unreadMessages)
        image.set(image: Icons.profile(icon: username, size: .medium))
        self.username.text = username
        self.message.text = message
    }
    
    func configureNumberOfMessages(unreadMessages: Int) {
        if unreadMessages > 0 {
            contentView.addSubview(numberOfMessages)
            
            numberOfMessages.set(number: unreadMessages)
            userTrailing.isActive = false
            userTrailingUnreadMessages.isActive = true
            
            NSLayoutConstraint.activate([
                numberOfMessages.centerYAnchor.constraint(equalTo: centerYAnchor),
                numberOfMessages.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20),
                numberOfMessages.heightAnchor.constraint(equalToConstant: 20),
                numberOfMessages.widthAnchor.constraint(equalToConstant: 20),
            ])
        } else {
            userTrailingUnreadMessages.isActive = false
            userTrailing.isActive = true
            numberOfMessages.removeFromSuperview()
        }
    }
}
