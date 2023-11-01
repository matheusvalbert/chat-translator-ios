//
//  CTProfileView.swift
//  UIComponents
//
//  Created by Matheus Valbert on 11/08/23.
//

import UIKit
import UIComponents
import DataComponents

class CTProfileView: UIView {
    
    let image = CTImageView(image: Icons.profile(icon: "t", size: .large))
    
    let username = CTLabel(text: "", numberOfLines: 1, font: .title1)
    let language = CTLabel(text: "", numberOfLines: 1, font: .body)
    public let button = CTIconButton(image: Icons.edit)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(profile: UserDomain) {
        self.init(frame: .zero)
        set(profile: profile)
    }
    
    func set(profile: UserDomain) {
        let fullUsername = profile.username + "#" + String(profile.tag)
        self.username.set(text: fullUsername)
        self.language.set(text: profile.language.rawValue.localizedCapitalized)
    }
    
    private func configure() {
        backgroundColor = .secondarySystemFill
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        addSubview(image)
        addSubview(username)
        addSubview(language)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            
            button.topAnchor.constraint(equalTo: username.topAnchor),
            button.widthAnchor.constraint(equalToConstant: 10),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            username.topAnchor.constraint(equalTo: image.topAnchor, constant: 15),
            username.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            username.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
            username.bottomAnchor.constraint(equalTo: language.topAnchor),
            
            language.topAnchor.constraint(equalTo: username.bottomAnchor),
            language.leadingAnchor.constraint(equalTo: username.leadingAnchor),
            language.trailingAnchor.constraint(equalTo: username.trailingAnchor),
            language.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -15),
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
