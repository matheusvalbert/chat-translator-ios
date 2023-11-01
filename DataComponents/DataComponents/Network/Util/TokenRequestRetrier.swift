//
//  TokenRequestRetrier.swift
//  DataComponents
//
//  Created by Matheus Valbert on 04/09/23.
//

import Foundation
import Alamofire

final class TokenRequestRetrier: RequestRetrier {
    
    let maxRetryCount = 3
    
    func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (Alamofire.RetryResult) -> Void) {
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 500 && request.retryCount < maxRetryCount {
            
            Task {
                do {
                    let headers: HTTPHeaders = [
                        "Authorization": "Bearer \(Token.fetchRefresherToken())"
                    ]
                    
                    let credentials = try await AF.request(Api.user(.renew).route, method: .post, headers: headers).serializingDecodable(RenewResponse.self, decoder: NetworkCodable.decode()).value
                    
                    Token.insert(token: credentials.token, refresherToken: credentials.refresherToken)
                    
                    completion(.retryWithDelay(2))
                } catch {
                    completion(.doNotRetryWithError(error))
                }
            }
        }
        
        completion(.doNotRetry)
    }
}
