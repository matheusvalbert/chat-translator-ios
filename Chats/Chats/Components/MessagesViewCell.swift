//
//  MessagesViewCell.swift
//  Chats
//
//  Created by Matheus Valbert on 14/08/23.
//

import UIKit
import UIComponents
import DataComponents

class MessagesViewCell: UITableViewCell {

    public static let reuseID = "MessagesCell"
    
    let image = CTImageView(image: Icons.profile(icon: "t", size: .small))
    let username = CTLabel(text: "username", numberOfLines: 1, font: .headline)
    let message = CTLabel(text: "message", numberOfLines: 0, font: .body)
    let translatedMessage = CTLabel(text: "translated message", numberOfLines: 0, font: .body, textColor: .secondaryLabel)
    let errorButton = CTIconButton(image: Icons.error, color: .systemRed)
    var errorButtonTapped: (() -> Void)? = nil
    
    var messageTrailing: NSLayoutConstraint!
    var messageTrailingError: NSLayoutConstraint!
    
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
        contentView.addSubview(translatedMessage)
        
        messageTrailing = message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        messageTrailingError = message.trailingAnchor.constraint(equalTo: errorButton.leadingAnchor, constant: -5)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.widthAnchor.constraint(equalToConstant: 65),
            image.heightAnchor.constraint(equalToConstant: 65),
            
            username.topAnchor.constraint(equalTo: image.topAnchor, constant: 3),
            username.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            username.bottomAnchor.constraint(equalTo: message.topAnchor),
            
            message.topAnchor.constraint(equalTo: username.bottomAnchor),
            message.leadingAnchor.constraint(equalTo: username.leadingAnchor),
            messageTrailing,
            message.bottomAnchor.constraint(equalTo: translatedMessage.topAnchor),
            
            translatedMessage.topAnchor.constraint(equalTo: message.bottomAnchor),
            translatedMessage.leadingAnchor.constraint(equalTo: message.leadingAnchor),
            translatedMessage.trailingAnchor.constraint(equalTo: message.trailingAnchor),
            translatedMessage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
        
        errorButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func addErrorButton() {
        contentView.addSubview(errorButton)
        
        messageTrailing.isActive = false
        messageTrailingError.isActive = true
        
        NSLayoutConstraint.activate([
            errorButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            errorButton.widthAnchor.constraint(equalToConstant: 10),
            errorButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            errorButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func removeErrorButton() {
        messageTrailingError.isActive = false
        messageTrailing.isActive = true
        errorButton.removeFromSuperview()
    }
}

extension MessagesViewCell {
    
    @objc private func buttonAction() {
        errorButtonTapped?()
    }
}
