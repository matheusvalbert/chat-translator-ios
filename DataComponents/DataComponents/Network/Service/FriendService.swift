//
//  FriendServiceImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 11/09/23.
//

import Foundation
import Alamofire

public final class FriendService {
    
    let session: NetworkSession
    let decoder: JSONDecoder
    
    init(session: NetworkSession) {
        self.session = session
        decoder = NetworkCodable.decode()
    }
    
    func request(data: RequestRequest) async throws {
        let _ = try await session.fetch().request(Api.friend(.request).route, method: .post, parameters: data, encoder: .json).validate().serializingDecodable(EmptyResponse.self, decoder: decoder).value
    }
    
    func response(data: ResponseRequest) async throws {
        let _ = try await session.fetch().request(Api.friend(.response).route, method: .put, parameters: data, encoder: .json).validate().serializingDecodable(EmptyResponse.self, decoder: decoder).value
    }
    
    func list() async throws -> ListResponse {
        return try await session.fetch().request(Api.friend(.list).route, method: .get).validate().serializingDecodable(ListResponse.self, decoder: decoder).value
    }
}
