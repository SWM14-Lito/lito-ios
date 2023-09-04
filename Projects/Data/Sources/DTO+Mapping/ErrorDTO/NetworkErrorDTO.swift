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
    case tokenExpired
    
    public var debugString: String {
        switch self {
        case .clientError(let error):
            return "⛑️ Client Error: \(error.localizedDescription) "
        case .requestError(let description):
            return "⛑️ Request Error \(description)"
        case .serverError(let response):
            let serverErrorMessage = convertServerErrorMessage(response: response)
            return "⛑️ Server Error \(response.description)\n" + (serverErrorMessage?.description ?? "")
        case .underlyingError(let error, let response):
            if let response = response {
                let serverErrorMessage = convertServerErrorMessage(response: response)
                return "⛑️ UnderlyingError \(error.localizedDescription)\n" + (serverErrorMessage?.description ?? "")
            }
            return "⛑️ UnderlyingError \(error.localizedDescription)"
        case .tokenExpired:
            return "⛑️ Token Expired"
        }
    }
    
    public func toVO() -> ErrorVO {
        switch self {
        case .clientError(_):
            return .fatalError
        case .requestError(_):
            return .fatalError
        case .serverError(let response):
            if 500...599 ~= response.statusCode || 429 == response.statusCode {
                let serverErrorMessage = convertServerErrorMessage(response: response)
                return .retryableError(serverErrorMessage?.message)
            } else {
                return .fatalError
            }
        case .underlyingError(_, let response):
            if let response = response {
                let serverErrorMessage = convertServerErrorMessage(response: response)
                return .retryableError(serverErrorMessage?.message)
            } else {
                return .fatalError
            }
        case .tokenExpired:
            return .tokenExpired
        }
    }
    
    private struct ServerErrorMessage: Decodable {
        let time: String
        let status: Int
        let message: String
        let code: String
        let errors: [DetailedErrors]
        
        public var description: String {
            var serverErrorResponse = """
                🔊 Server Error Response
                time: \(time)
                status code: \(String(status)) - \(httpStatusDescription)
                code: \(code) - \(message)
                🧐errors:\n
                """
            for error in errors {
                serverErrorResponse += """
                    field: \(error.field)
                    value: \(error.value ?? "nil")
                    reason: \(error.reason)
                    ----------------------
                    """
            }
            return serverErrorResponse
        }
        
        struct DetailedErrors: Decodable {
            let field: String
            let value: String?
            let reason: String
        }
        
        public var httpStatusDescription: String {
            switch self.status {
            case 200:
                return "성공"
            case 400:
                return "잘못된 요청"
            case 401:
                return "비인증 상태"
            case 403:
                return "권한 거부"
            case 404:
                return "존재하지 않는 요청 리소스"
            case 405:
                return "API 는 존재하나 Method가 존재하지 않는 경우"
            case 500:
                return "서버 에러"
            default:
                return "정의되지 않은 에러"
            }
        }
        
    }
    
    private func convertServerErrorMessage(response: Response) -> ServerErrorMessage? {
        do {
            let serverErrorMessage = try JSONDecoder().decode(ServerErrorMessage.self, from: response.data)
            return serverErrorMessage
        } catch {
            print("🫠Failed to decode serverErrorMessage\n")
            print("⭐️plain response is below")
            print(String(data: response.data, encoding: .utf8) ?? "no response")
            return nil
        }
    }
}
