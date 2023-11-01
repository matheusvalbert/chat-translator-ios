//
//  InjectTokenRequestAdapter.swift
//  DataComponents
//
//  Created by Matheus Valbert on 04/09/23.
//

import Foundation
import Alamofire

final class InjectTokenRequestAdapter: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var modifiedRequest = urlRequest
        modifiedRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        modifiedRequest.setValue("Bearer \(Token.fetchToken())", forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }
}
