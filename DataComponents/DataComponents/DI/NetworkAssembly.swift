//
//  NetworkAssembly.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation
import Swinject

public final class NetworkAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(InjectTokenRequestAdapter.self) { resolver in
            
            return InjectTokenRequestAdapter()
        }
        
        container.register(TokenRequestRetrier.self) { resolver in
            
            return TokenRequestRetrier()
        }
        
        container.register(NetworkSession.self) { resolver in
            guard let injectTokenRequestAdapter = resolver.resolve(InjectTokenRequestAdapter.self) else {
                fatalError("inject token request adapter dependency could not be resolved")
            }
            
            guard let tokenRequestRetrier = resolver.resolve(TokenRequestRetrier.self) else {
                fatalError("token request retrier dependency could not be resolved")
            }
            
            return NetworkSession(injectTokenRequestAdapter: injectTokenRequestAdapter, tokenRequestRetrier: tokenRequestRetrier)
        }
        
        container.register(UserService.self) { resolver in
            guard let networkSession = resolver.resolve(NetworkSession.self) else {
                fatalError("network session dependency could not be resolved")
            }
            
            return UserService(session: networkSession)
        }
        
        container.register(FriendService.self) { resolver in
            guard let networkSession = resolver.resolve(NetworkSession.self) else {
                fatalError("network session dependency could not be resolved")
            }
            
            return FriendService(session: networkSession)
        }
        
        container.register(MessageService.self) { resolver in
            guard let networkSession = resolver.resolve(NetworkSession.self) else {
                fatalError("network session dependency could not be resolved")
            }
            
            return MessageService(session: networkSession)
        }
    }
}
