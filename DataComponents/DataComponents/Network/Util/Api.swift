//
//  Api.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation

enum Api {
    
    private static let baseUrl = "https://w1rh6zmiw6.execute-api.us-east-2.amazonaws.com"
    
    case user(UserRoute)
    case friend(FriendRoute)
    case message(MessageRoute)
    
    var route: String {
        switch self {
        case .user(let userRoute):
            return Api.baseUrl + userRoute.route
        case .friend(let friendRoute):
            return Api.baseUrl + friendRoute.route
        case .message(let messageRoute):
            return Api.baseUrl + messageRoute.route
        }
    }
    
    static func route(route: Self) -> String {
        return route.route
    }
}

enum UserRoute: String {
    
    private static let prefix = "/user"
    
    case login = "/login"
    case renew = "/renew"
    case info = "/info"
    case update = "/update"
    case updateToken = "/update-token"
    
    var route: String {
        return UserRoute.prefix + self.rawValue
    }
}

enum FriendRoute: String {
    
    private static let prefix = "/friend"
    
    case request = "/request"
    case response = "/response"
    case list = "/list"
    
    var route: String {
        return FriendRoute.prefix + self.rawValue
    }
}

enum MessageRoute: String {
    
    private static let prefix = "/message"
    
    case send = "/send"
    case receive = "/receive"
    case confirm = "/confirm"
    
    var route: String {
        return MessageRoute.prefix + self.rawValue
    }
}
