//
//  EventAssembly.swift
//  DataComponents
//
//  Created by Matheus Valbert on 02/10/23.
//

import Foundation
import Swinject

public final class EventAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(ChatEventBus.self) { resolver in
            
            return ChatEventBus()
        }.inObjectScope(.container)
        
        container.register(MessageEventBus.self) { resolver in
            
            return MessageEventBus()
        }.inObjectScope(.container)
    }
}
