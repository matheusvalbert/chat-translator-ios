//
//  MessagesTableView.swift
//  Chats
//
//  Created by Matheus Valbert on 15/08/23.
//

import UIKit

class MessagesTableView: UITableView {
    
    var keyboardSize: CGFloat = 0
    var singleLoad = false
    
    var safeAreaBottom: CGFloat = 0
    var safeAreaTop: CGFloat = 0

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        keyboardDismissMode = .interactiveWithAccessory
        allowsSelection = false
        allowsFocus = false
                
        register(MessagesViewCell.self, forCellReuseIdentifier: MessagesViewCell.reuseID)
    }
    
    func configureBottomInsets(size: CGFloat) {
        contentInset.bottom = size
        verticalScrollIndicatorInsets.bottom = size
    }
    
    func scrollToBottom(row: Int, animated: Bool = false) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: row - 1, section: 0)
            if row > 0 {
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
}
