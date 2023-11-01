//
//  MessageService.swift
//  DataComponents
//
//  Created by Matheus Valbert on 19/09/23.
//

import Foundation
import Alamofire

public final class MessageService {
    
    let session: NetworkSession
    let encoder: JSONParameterEncoder
    let decoder: JSONDecoder
    
    init(session: NetworkSession) {
        self.session = session
        encoder = JSONParameterEncoder(encoder: NetworkCodable.encode())
        decoder = NetworkCodable.decode()
    }
    
    func send(data: SendRequest) async throws -> SendResponse {
        return try await session.fetch().request(Api.message(.send).route, method: .post, parameters: data, encoder: .json).validate().serializingDecodable(SendResponse.self, decoder: decoder).value
    }
    
    func receive() async throws -> ListReceiveResponse {
        return try await session.fetch().request(Api.message(.receive).route, method: .get).validate().serializingDecodable(ListReceiveResponse.self, decoder: decoder).value
    }
    
    func delete(data: ConfirmRequest) async throws {
        _ = try await session.fetch().request(Api.message(.confirm).route, method: .delete, parameters: data, encoder: encoder ).validate().serializingDecodable(EmptyResponse.self, decoder: decoder).value
    }
}
