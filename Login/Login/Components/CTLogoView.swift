//
//  CTLogo.swift
//  UIComponents
//
//  Created by Matheus Valbert on 02/08/23.
//

import UIKit
import UIComponents

class CTLogoView: UIView {
    
    let logo = UIImageView(image: Images.logo)
    let title = CTTitle(title: "Chat Translator")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(logo)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: topAnchor),
            logo.leadingAnchor.constraint(equalTo: leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: trailingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 159),
            logo.widthAnchor.constraint(equalToConstant: 300),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
    }
}
