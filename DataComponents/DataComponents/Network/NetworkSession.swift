//
//  Session.swift
//  DataComponents
//
//  Created by Matheus Valbert on 04/09/23.
//

import Foundation
import Alamofire

public final class NetworkSession {
    
    let session: Session
    
    init(injectTokenRequestAdapter: InjectTokenRequestAdapter, tokenRequestRetrier: TokenRequestRetrier) {
        let interceptor = Interceptor(adapter: injectTokenRequestAdapter, retrier: tokenRequestRetrier)
        session = Session(interceptor: interceptor)
    }
    
    func fetch() -> Session {
        return session
    }
}
