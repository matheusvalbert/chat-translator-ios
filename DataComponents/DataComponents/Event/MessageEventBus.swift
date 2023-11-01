//
//  MessageEventBus.swift
//  DataComponents
//
//  Created by Matheus Valbert on 02/10/23.
//

import Foundation
import Combine

public class MessageEventBus {
    
    public let event = PassthroughSubject<MessageDomain, Never>()
}
