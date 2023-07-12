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
    
    case encodeError(Error)
    case mappingError(Response)
    case requestError(String)
    case statusCode(Response)
    case underlyingError(Error, Response?)
    
    // TODO: 서버와 협의하여 Error string 구성
    public var debugString: String {
        switch self {
        case .encodeError(let error):
            return "⛑️ Encode Error: \(error.localizedDescription) "
        case .mappingError(let response):
            print(String(decoding: response.data, as: UTF8.self))
            return "⛑️ Mapping Error: \(response.description)"
        case .requestError(let description):
            return "⛑️ Request Error \(description)"
        case .statusCode(let response):
            return "⛑️ StatuCode Error \(response.statusCode)"
        case .underlyingError(let error, let response):
            return "⛑️ UnderlyingError \(error.localizedDescription) \n response: \(String(describing: response))"
        }
    }
    
    public func toVO() -> ErrorVO {
        // TODO: 상황에 맞게 지속적으로 Error handling 업데이트 필요
        switch self {
        case .encodeError(_):
            return .fatalError
        case .mappingError(_):
            return .fatalError
        case .requestError(_):
            return .fatalError
        case .statusCode(let response):
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
    
}
