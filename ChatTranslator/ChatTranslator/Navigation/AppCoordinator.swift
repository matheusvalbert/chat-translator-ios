//
//  AppCoordinator.swift
//  ChatTranslator
//
//  Created by Matheus Valbert on 04/08/23.
//

import UIKit
import UIComponents
import DataComponents
import Chats
import Profile
import Friend

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    let tabBarController = UITabBarController()
    var chatsNC: UINavigationController?
    var profileNC: UINavigationController?
    var friendsNC: UINavigationController?
    
    unowned let navigationController: UINavigationController
        
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            
            chatsNC = createChatsNC()
            profileNC = createProfileNC()
            friendsNC = createFriendsNC()
            tabBarController.viewControllers = [friendsNC!, chatsNC!, profileNC!]
            tabBarController.selectedViewController = chatsNC
            
            if let window = windowScene.windows.first {
                window.rootViewController = tabBarController
                
                let friendRepository: FriendRepository = DIContainer.shared.resolve()
                let chatRepository: ChatRepository = DIContainer.shared.resolve()
                
                Task {
                    let waitingFriends = try await friendRepository.count(byStatus: .waiting)
                    let unreadMessages = try await chatRepository.getUnreadMessagesCount()
                    
                    DispatchQueue.main.async {
                        self.updateBarBadge(type: .friends, value: waitingFriends != 0 ? String(waitingFriends) : nil)
                        self.updateBarBadge(type: .chats, value: unreadMessages != 0 ? String(unreadMessages) : nil)
                    }
                }
            }
        }
    }
    
    private func createChatsNC() -> UINavigationController {
        let chatsVC = ChatsViewController()
        chatsVC.viewModel = DIContainer.shared.resolve()
        chatsVC.delegate = self
        chatsVC.tabBarItem = UITabBarItem(title: "Chats", image: Icons.chats, selectedImage: Icons.chatsSelected)
        return UINavigationController(rootViewController: chatsVC)
    }
    
    private func createProfileNC() -> UINavigationController {
        let profileVC = ProfileViewController()
        profileVC.viewModel = DIContainer.shared.resolve()
        profileVC.delegate = self
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: Icons.profile, selectedImage: Icons.profileSelected)
        return UINavigationController(rootViewController: profileVC)
    }
    
    private func createFriendsNC() -> UINavigationController {
        let friendsVC = FriendsViewController()
        friendsVC.viewModel = DIContainer.shared.resolve()
        friendsVC.delegate = self
        friendsVC.tabBarItem = UITabBarItem(title: "Friends", image: Icons.friends, selectedImage: Icons.friendsSelected)
        return UINavigationController(rootViewController: friendsVC)
    }
}

extension AppCoordinator: FriendsViewControllerDelegate, ChatsViewControllerDelegate, NewChatViewControllerDelegate, ProfileViewControllerDelegate {
    
    func navigateToChatMessages(friend: FriendDomain) {
        let vc = MessagesViewController()
        vc.viewModel = DIContainer.shared.resolve()
        vc.viewModel?.navigateToMessages(friend: friend)
        vc.hidesBottomBarWhenPushed = true
        if tabBarController.selectedViewController == friendsNC {
            friendsNC?.pushViewController(vc, animated: true)
        } else {
            chatsNC?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToNewChat() {
        let vc = NewChatViewController()
        vc.viewModel = DIContainer.shared.resolve()
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        chatsNC?.present(nc, animated: true)
    }
    
    func openEditProfileModal() {
        let vc = EditProfileViewController()
        vc.viewModel = DIContainer.shared.resolve()
        let nc = UINavigationController(rootViewController: vc)
        profileNC?.present(nc, animated: true)
    }
    
    func navigateToFriendRequest() {
        let vc = FriendRequestViewController()
        vc.viewModel = DIContainer.shared.resolve()
        let nc = UINavigationController(rootViewController: vc)
        friendsNC?.present(nc, animated: true)
    }
    
    func navigateToAddFriends() {
        let vc = AddFriendViewController()
        vc.viewModel = DIContainer.shared.resolve()
        let nc = UINavigationController(rootViewController: vc)
        friendsNC?.present(nc, animated: true)
    }
}

extension AppCoordinator: ExposedCoordinator {
    
    public func updateBarBadge(type: TabBarType, value: String?) {
        if let tabBarItem = tabBarController.tabBar.items?[type.rawValue] {
            tabBarItem.badgeValue = value
        }
    }
    
    func fetchFriendsFromNotification() {
        DispatchQueue.main.async {
            if self.tabBarController.selectedIndex == TabBarType.friends.rawValue {
                self.tabBarController.selectedIndex = TabBarType.chats.rawValue
                self.tabBarController.selectedIndex = TabBarType.friends.rawValue
            }
        }
    }
    
    @MainActor
    public func navigateToFriendRequestFromNotification(tag: Int64) async throws {
        let vc = FriendRequestViewController()
        vc.viewModel = DIContainer.shared.resolve()
        await vc.viewModel?.reload()
        await vc.viewModel?.fetch()
        self.tabBarController.selectedIndex = TabBarType.friends.rawValue
        vc.viewModel?.selectedIndex = vc.viewModel?.friends.firstIndex { $0.tag == tag }
        let nc = UINavigationController(rootViewController: vc)
        self.friendsNC?.present(nc, animated: true)
    }
    
    @MainActor
    public func navigateToChatMessagesFromNotification(username: String, tag: Int64) async throws {
        self.tabBarController.selectedIndex = TabBarType.chats.rawValue
        let vc = MessagesViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel = DIContainer.shared.resolve()
        await vc.viewModel?.fetchChats()
        vc.viewModel?.navigateToMessages(friend: FriendDomain(username: username, tag: tag, status: FriendStatus.accepted.rawValue))
        self.chatsNC?.pushViewController(vc, animated: true)
    }
    
    func navigateToFriendsFromNotification() {
        DispatchQueue.main.async { self.tabBarController.selectedIndex = TabBarType.friends.rawValue }
    }
}
