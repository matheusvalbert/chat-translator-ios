//
//  UserServiceImpl.swift
//  DataComponents
//
//  Created by Matheus Valbert on 30/08/23.
//

import Foundation
import Alamofire

public final class UserService {
    
    let session: NetworkSession
    let encoder: JSONParameterEncoder
    let decoder: JSONDecoder
    
    init(session: NetworkSession) {
        self.session = session
        encoder = JSONParameterEncoder(encoder: NetworkCodable.encode())
        decoder = NetworkCodable.decode()
    }
    
    func login(token: String) async throws -> LoginResponse {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        return try await AF.request(Api.user(.login).route, method: .post, headers: headers).serializingDecodable(LoginResponse.self, decoder: decoder).value
    }
    
    func fetch() async throws -> InfoResponse {
        return try await session.fetch().request(Api.user(.info).route, method: .get).serializingDecodable(InfoResponse.self, decoder: decoder).value
    }
    
    func update(data: UpdateRequest) async throws {
        let _ = try await session.fetch().request(Api.user(.update).route, method: .put, parameters: data, encoder: .json).validate().serializingDecodable(EmptyResponse.self, decoder: decoder).value
    }
    
    func update(token: UpdateTokenRequest) async throws {
        let _ = try await session.fetch().request(Api.user(.updateToken).route, method: .put, parameters: token, encoder: encoder).validate().serializingDecodable(EmptyResponse.self, decoder: decoder).value
    }
}
