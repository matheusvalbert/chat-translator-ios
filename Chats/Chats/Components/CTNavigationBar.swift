//
//  CTNavigationBar.swift
//  ChatMessages
//
//  Created by Matheus Valbert on 12/08/23.
//

import UIKit
import UIComponents

class CTNavigationBar: UIStackView {
    
    let profileImage = CTImageView(image: Icons.profile(icon: "", size: .small))
    let username = CTLabel(text: "", numberOfLines: 1, font: .headline)
    let spacer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow
        
        addArrangedSubview(profileImage)
        addArrangedSubview(username)
        addArrangedSubview(spacer)
        
        axis = .horizontal

        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(username: String) {
        profileImage.set(image: Icons.profile(icon: username, size: .small))
        self.username.set(text: username)
    }
}
