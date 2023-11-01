//
//  Date+Ext.swift
//  UIComponents
//
//  Created by Matheus Valbert on 03/10/23.
//

import Foundation

extension Date {
    
    public func convertToShortDate() -> String {
        return formatted(date: .abbreviated, time: .shortened)
    }
}
