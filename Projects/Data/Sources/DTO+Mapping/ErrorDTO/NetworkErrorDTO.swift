//
//  NetworkError.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/29.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Domain
import Moya

public enum NetworkErrorDTO: Error {
    
    case requestError(String)
    case clientError(Error)
    case serverError(Response)
    case underlyingError(Error, Response?)
    
    public var debugString: String {
        switch self {
        case .clientError(let error):
            return "⛑️ Client Error: \(error.localizedDescription) "
        case .requestError(let description):
            return "⛑️ Request Error \(description)"
        case .serverError(let response):
            let serverErrorMessage = convertServerErrorMessage(response: response)
            return "⛑️ Server Error \(response.statusCode)\n" + (serverErrorMessage?.description ?? "🫠Failed to decode serverErrorMessage")
        case .underlyingError(let error, let response):
            if let response = response {
                let serverErrorMessage = convertServerErrorMessage(response: response)
                return "⛑️ UnderlyingError \(error.localizedDescription)\n" + (serverErrorMessage?.description ?? "🫠Failed to decode serverErrorMessage")
            }
            return "⛑️ UnderlyingError \(error.localizedDescription)"
        }
    }
    
    public func toVO() -> ErrorVO {
        // TODO: 상황에 맞게 지속적으로 Error handling 업데이트 필요
        switch self {
        case .clientError(_):
            return .fatalError
        case .requestError(_):
            return .fatalError
        case .serverError(let response):
            if 500...599 ~= response.statusCode {
                return .retryableError
            }
            if 429 == response.statusCode {
                return .retryableError
            }
            if 429 == response.statusCode {
                return .retryableError
            }
            return .fatalError
        case .underlyingError(_, _):
            return .fatalError
        }
    }
    
    private struct ServerErrorMessage: Decodable {
        let time: String
        let status: Int
        let message: String
        let code: String
        let errors: [String]
        
        public var description: String {
            return """
                🔊 Server Error Response
                \(self.time)
                status code: \(String(self.status))
                message: \(self.message)
                code: \(self.code)
                errors: \(self.errors)
                """
        }
        
    }
    
    private func convertServerErrorMessage(response: Response) -> ServerErrorMessage? {
        do {
            let serverErrorMessage = try JSONDecoder().decode(ServerErrorMessage.self, from: response.data)
            return serverErrorMessage
        } catch {
            return nil
        }
    }
    
}
