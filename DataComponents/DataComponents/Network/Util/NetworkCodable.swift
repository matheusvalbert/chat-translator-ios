//
//  Decoder.swift
//  DataComponents
//
//  Created by Matheus Valbert on 04/09/23.
//

import Foundation

enum NetworkCodable {
    
    static func encode() -> JSONEncoder {
        let encoder = JSONEncoder()
        
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }
    
    static func decode() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
}
