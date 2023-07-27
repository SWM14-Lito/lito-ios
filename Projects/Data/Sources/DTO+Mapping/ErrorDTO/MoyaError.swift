//
//  MoyaError.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya

extension MoyaError {
    
    public func toNetworkError() -> NetworkErrorDTO {
        switch self {
            // Client Error
        case .encodableMapping(let error):
            return NetworkErrorDTO.clientError(error)
        case .parameterEncoding(let error):
            return NetworkErrorDTO.clientError(error)
            // Request Error
        case .requestMapping(let string):
            return NetworkErrorDTO.requestError(string)
            // Server Error
        case .imageMapping(let response):
            return NetworkErrorDTO.serverError(response)
        case .jsonMapping(let response):
            return NetworkErrorDTO.serverError(response)
        case .objectMapping(_, let response):
            return NetworkErrorDTO.serverError(response)
        case .stringMapping(let response):
            return NetworkErrorDTO.serverError(response)
        case .statusCode(let response):
            return NetworkErrorDTO.serverError(response)
            // Underlying Error
        case .underlying(let error, let response):
            if response?.statusCode == 401, let httpUrlResponse = response?.response {
                if httpUrlResponse.url?.lastPathComponent == "reissue" {
                    return NetworkErrorDTO.tokenExpired
                }
            }
            return NetworkErrorDTO.underlyingError(error, response)
        }
    }
    
}
