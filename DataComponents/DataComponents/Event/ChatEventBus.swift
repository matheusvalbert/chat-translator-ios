//
//  ChatEventBus.swift
//  DataComponents
//
//  Created by Matheus Valbert on 25/10/23.
//

import Foundation
import Combine

public class ChatEventBus {
    
    public let event = PassthroughSubject<ChatDomain, Never>()
}
