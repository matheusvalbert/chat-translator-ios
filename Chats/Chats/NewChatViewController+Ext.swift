//
//  NewChatViewController+Ext.swift
//  Chats
//
//  Created by Matheus Valbert on 24/08/23.
//

import UIKit
import UIComponents

extension NewChatViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.friends.count)!
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friend = viewModel?.friends[indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseID) as! FriendsCell
        cell.set(username: friend.username + "#" + String(friend.tag))
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cancelView()
        delegate?.navigateToChatMessages(friend: viewModel!.friends[indexPath.row])
    }
}
