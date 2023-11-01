//
//  MessageInputBottomView.swift
//  Chats
//
//  Created by Matheus Valbert on 15/08/23.
//

import UIKit

class MessageBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func create(view: UIView) {
        view.addSubview(self)
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func add() {
        backgroundColor = .secondarySystemBackground
    }
    
    func remove() {
        backgroundColor = nil
    }
}
