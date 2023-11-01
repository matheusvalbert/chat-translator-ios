//
//  MessagesViewController+Ext.swift
//  Chats
//
//  Created by Matheus Valbert on 14/08/23.
//

import UIKit
import UIComponents

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.messages.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessagesViewCell.reuseID) as! MessagesViewCell
        let message = viewModel?.messages[indexPath.row]
        
        let username = message!.senderOrReceiver == .sender ? "You" : viewModel?.selectedFriend?.username
        let date = " \(message!.date?.convertToShortDate() ?? "")"
        
        cell.image.set(image: Icons.profile(icon: username!, size: .small))
        
        let usernameField = NSMutableAttributedString(string: username!)
        usernameField.append(NSAttributedString(string: date, attributes: [
            .foregroundColor: UIColor.secondaryLabel,
            .font: UIFont.preferredFont(forTextStyle: .subheadline),
        ]))
        cell.username.attributedText = usernameField
        
        cell.message.text = message!.message
        cell.translatedMessage.text = message!.translatedMessage
        
        if message?.status == .error {
            cell.addErrorButton()
        } else {
            cell.removeErrorButton()
        }
        
        cell.errorButtonTapped = {
            Task {
                cell.errorButton.isEnabled = false
                await self.viewModel?.retrySendMessage(id: message!.id)
                cell.errorButton.isEnabled = true
            }
        }
        
        return cell
    }
}
