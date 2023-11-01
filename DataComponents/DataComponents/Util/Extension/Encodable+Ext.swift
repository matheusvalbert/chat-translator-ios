//
//  DomainEncoder.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation

extension Encodable {
    
    func encodeToEntity() throws -> [[String: Any]] {
        
        let encoder = JSONEncoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        let jsonData = try encoder.encode(self)
        
        return (try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: Any]]).map {
            var item = $0
            if let date = item["date"] as? String {
                item["date"] = dateFormatter.date(from: date)
            }
            if let id = item["id"] as? String {
                item["id"] = UUID(uuidString: id)
            }
            return item
        }
    }
}
