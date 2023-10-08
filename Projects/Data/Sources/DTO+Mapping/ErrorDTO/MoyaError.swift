//
//  MoyaError.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya
import Domain

extension MoyaError {
    
    /*
     /// Response의 data를 이미지로 맵핑하는 과정에서 발생할 수 있는 에러
     case imageMapping(Response)
     
     /// Response의 data를 json 으로 맵핑하는 과정에서 발생할 수 있는 에러
     case jsonMapping(Response)
     
     /// Response의 data를 string 으로 맵핑하는 과정에서 발생할 수 있는 에러
     case stringMapping(Response)
     
     /// Response의 data를 특정 타입으로 파싱하는 과정에서 발생할 수 있는 에러
     case objectMapping(Swift.Error, Response)
     
     /// URLRequest를 만들때 httpBody 를 인코딩하는 과정에서 발생할 수 있는 에러
     case encodableMapping(Swift.Error)
     
     /// Response 의 statusCode가 설정한 statusCode에 포함되지 않는다면 발생하는 에러
     case statusCode(Response)
     
     /// URLRequest 요청, 수행과정에서 발생할 수 있는 에러
     case underlying(Swift.Error, Response?)
     
     /// URLRequest를 만들때 String 을 URL로 변환하는 과정에서 발생할 수 있는 에러
     case requestMapping(String)
     
     /// URLRequest를 만들때 parameter 를 인코딩하는 과정에서 발생할 수 있는 에러
     case parameterEncoding(Swift.Error)
     */
    
    public func toVO() -> ErrorVO {
        switch self {
        case .underlying(let error, let response):
            // 토큰 재발급 실패
            if let afError = error.asAFError, afError.isRequestRetryError {
                if case .requestRetryFailed = afError {
                    if response?.statusCode == 401 {
                        return .tokenExpired
                    }
                }
            }
            if let response = response {
                if response.statusCode == 500 {
                    do {
                        let serverErrorMessage = try convertServerErrorMessage(response: response)
                        return .retryableError(serverErrorMessage.errors[0].reason)
                    } catch {
                        return .retryableError("일시적인 서버 에러입니다. 잠시 후 다시 시도해주세요.")
                    }
                }
                // 리팩토링 필요.
                if response.statusCode == 400 {
                    do {
                        let serverErrorMessage = try convertServerErrorMessage(response: response)
                        if serverErrorMessage.code == "U002" {
                            return .retryableError(serverErrorMessage.message)
                        }
                    } catch {
                        return .fatalError
                    }
                }
            }
            return .fatalError
        default:
            return .fatalError
        }
    }
    
    public var debugString: String {
        switch self {
        case .imageMapping(let response):
            return makeDebugString(title: "imageMapping", response: response, dataParse: false)
        case .jsonMapping(let response):
            return makeDebugString(title: "jsonMapping", response: response, dataParse: true)
        case .stringMapping(let response):
            return makeDebugString(title: "stringMapping", response: response)
        case .objectMapping(let error, let response):
            return makeDebugString(title: "objectMapping", response: response, error: error)
        case .encodableMapping(let error):
            return makeDebugString(title: "encodableMapping", error: error)
        case .statusCode(let response):
            return makeDebugString(title: "statusCode", response: response)
        case .underlying(let error, let response):
            return makeDebugString(title: "underlying", response: response, error: error)
        case .requestMapping(let urlString):
            return makeDebugString(title: "requestMapping") + "urlString: \(urlString)"
        case .parameterEncoding(let error):
            return makeDebugString(title: "parameterEncoding", error: error)
        }
    }
    
    private func makeDebugString(title: String, response: Response? = nil, error: Error? = nil, dataParse: Bool = true) -> String {
        var debugDescription: String = "Empty"
        var errorLocalizedDescription: String = "Empty"
        var parsedData = "Empty"
        if let response = response {
            // response 를 우리측 서버의 ErrorMessage 로 변환 시도
            do {
                let serverErrorMessage = try convertServerErrorMessage(response: response)
                return """
                ⛑️ Moya \(title) Error
                \(serverErrorMessage.description)
                """
            } catch {
#if DEBUG
                print("Failed to Parse ServerErrorMessage \n \(error)")
#endif
                debugDescription = response.debugDescription
                if dataParse {
                    parsedData = String(data: response.data, encoding: .utf8) ?? "Empty"
                }
            }
        }
        if let error = error {
            errorLocalizedDescription = error.localizedDescription
        }
        return """
        ⛑️ Moya \(title) Error
        statusCode: \(response?.statusCode ?? 0)
        debugDescription: \(debugDescription)
        errorDescription: \(errorLocalizedDescription)
        parsedData: \(parsedData)
        """
    }
    
}

extension MoyaError {
    
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
    
    private func convertServerErrorMessage(response: Response) throws -> ServerErrorMessage {
        do {
            let serverErrorMessage = try JSONDecoder().decode(ServerErrorMessage.self, from: response.data)
            return serverErrorMessage
        }
    }
    
}
