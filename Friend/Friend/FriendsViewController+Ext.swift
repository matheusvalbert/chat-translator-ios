//
//  FriendsViewController+Ext.swift
//  Friend
//
//  Created by Matheus Valbert on 23/08/23.
//

import UIKit
import UIComponents
import DataComponents

extension FriendsViewController {

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.friends.count)!
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friend = viewModel?.friends[indexPath.row] else { return UITableViewCell() }
        
        if friend.status == .accepted {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseID) as! FriendsCell
            cell.set(username: friend.username + "#" + String(friend.tag))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RequestFriendsCell.reuseID) as! RequestFriendsCell
            cell.set(username: friend.username + "#" + String(friend.tag), status: friend.status)
            return cell
        }
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let status = viewModel?.friends[indexPath.row].status else { return }
        
        switch status {
        case .accepted:
            delegate?.navigateToChatMessages(friend: viewModel!.friends[indexPath.row])
        case .waiting:
            viewModel?.selectedIndex = indexPath.row
            delegate?.navigateToFriendRequest()
            tableView.deselectRow(at: indexPath, animated: true)
        case .pending:
            present(alert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            break
        default:
            break
        }
    }
}
