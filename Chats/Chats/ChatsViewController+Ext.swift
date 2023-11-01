//
//  ChatsTableView.swift
//  Chats
//
//  Created by Matheus Valbert on 04/08/23.
//

import UIKit
import UIComponents
import DataComponents

extension ChatsViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chats.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatsViewCell.reuseID) as! ChatsViewCell
        
        let chat = viewModel?.chats[indexPath.row]
        
        let username = viewModel?.friends.first(where: { $0.tag == chat?.tag })?.username ?? ""
        
        cell.set(username: "\(username)#\(chat!.tag)", message: chat!.lastMessage, unreadMessages: Int(chat!.unreadMessages))
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.navigateToChatMessages(friend: viewModel!.friends[indexPath.row])
    }
    
    public override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let tag = viewModel?.chats[indexPath.row].tag
        
        viewModel?.removeChat(tag: tag!)
    }
}
