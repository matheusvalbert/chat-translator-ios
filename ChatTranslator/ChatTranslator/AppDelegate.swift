//
//  AppDelegate.swift
//  ChatTranslator
//
//  Created by Matheus Valbert on 30/07/23.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import GoogleSignIn
import Swinject
import DataComponents

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
                
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        UIApplication.shared.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Permission granted for notifications.")
            }
        }
        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token else {
                return
            }
            
            Task {
                let sendFirebaseTokenUseCase: SendFirebaseTokenUseCase = DIContainer.shared.resolve()
                try await sendFirebaseTokenUseCase.execute(token: token)
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            if granted {
                
                Task {
                    let messagingSelector: MessagingSelector = DIContainer.shared.resolve()
                    try await messagingSelector.received(message: userInfo)
                }
                
                return .newData
            }
        } catch {
            print(error)
            return .failed
        }
        
        return .noData
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.badge, .banner, .list, .sound]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        Task {
            let messagingSelector: MessagingSelector = DIContainer.shared.resolve()
            try await messagingSelector.replyed(message: response)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
