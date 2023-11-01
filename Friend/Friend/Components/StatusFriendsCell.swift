//
//  StatusFriendsCell.swift
//  Friend
//
//  Created by Matheus Valbert on 23/08/23.
//

import UIKit
import UIComponents
import DataComponents

class RequestFriendsCell: UITableViewCell {
    
    public static let reuseID = "RequestFriendsCell"
    
    let image = CTImageView(image: Icons.profile(icon: "t", size: .small))
    let username = CTLabel(text: "Test#1", numberOfLines: 1, font: .headline)
    let status = CTLabel(text: "Loading...", numberOfLines: 1, font: .callout)

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
        contentView.addSubview(status)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            image.widthAnchor.constraint(equalToConstant: 45),
            image.heightAnchor.constraint(equalToConstant: 45),
            
            username.topAnchor.constraint(equalTo: image.topAnchor),
            username.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            status.topAnchor.constraint(equalTo: username.bottomAnchor),
            status.leadingAnchor.constraint(equalTo: username.leadingAnchor),
            status.trailingAnchor.constraint(equalTo: username.trailingAnchor),
            status.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    func set(username: String, status: FriendStatus) {
        image.set(image: Icons.profile(icon: username, size: .small))
        self.username.set(text: username)
        self.status.set(text: status.rawValue.localizedCapitalized + "...")
    }
}
