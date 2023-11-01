//
//  FriendsCell.swift
//  UIComponents
//
//  Created by Matheus Valbert on 24/08/23.
//

import UIKit

public class FriendsCell: UITableViewCell {

    public static let reuseID = "FriendsCell"

    let image = CTImageView(image: Icons.profile(icon: "t", size: .small))
    let username = CTLabel(text: "Test#1", numberOfLines: 1, font: .headline)
    
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
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            image.widthAnchor.constraint(equalToConstant: 45),
            image.heightAnchor.constraint(equalToConstant: 45),
            
            username.topAnchor.constraint(equalTo: image.topAnchor),
            username.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            username.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            username.bottomAnchor.constraint(equalTo: image.bottomAnchor),
        ])
    }
    
    public func set(username: String) {
        self.username.set(text: username)
        self.image.set(image: Icons.profile(icon: username, size: .small))
    }
}
