//
//  MessageInputView.swift
//  Chats
//
//  Created by Matheus Valbert on 14/08/23.
//

import UIKit
import UIComponents

class MessageInputView: UIView {
    
    var isEditing = false
    var textSize: CGFloat = 38
    var lineSize: CGFloat = 22
    
    let text = UITextView()
    let send = CTIconButton(image: Icons.send)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureText()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureText() {
        backgroundColor = .secondarySystemBackground
        
        addSubview(text)
        addSubview(send)
        
        text.layer.cornerRadius = 16
        text.font = UIFont.preferredFont(forTextStyle: .body)
        text.adjustsFontForContentSizeCategory = true
        
        text.tintColor = Colors.purple
        text.backgroundColor = .systemBackground
        
        text.textContainerInset.left = 5
        text.textContainerInset.right = 5
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        send.isEnabled = false
        
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            text.trailingAnchor.constraint(equalTo: send.leadingAnchor),
            text.heightAnchor.constraint(equalToConstant: textSize),
            
            send.trailingAnchor.constraint(equalTo: trailingAnchor),
            send.bottomAnchor.constraint(equalTo: text.bottomAnchor, constant: -4),
        ])
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func adjustSize() {
        text.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = textSize
            }
        }
        constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = textSize + lineSize
            }
        }
    }
}
