//
//  NetworkWrapper.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import Domain
import Moya
import CombineMoya

class MoyaWrapper<Provider: TargetType>: MoyaProvider<Provider> {
    
    func call<Value>(target: Provider) -> AnyPublisher<Value, Error> where Value: Decodable {
        return self.requestPublisher(target)
            .map(Value.self)
            .mapError { moyaError -> NetworkErrorDTO in
                print(moyaError)
                return moyaError.toNetworkError()
            }
            .eraseToAnyPublisher()
    }
    
    func call(target: Provider) -> AnyPublisher<Void, Error> {
        return self.requestPublisher(target)
            .catch({ moyaError -> Fail in
                print(moyaError)
                return Fail(error: ErrorVO.fatalError)
            })
//            .mapError { moyaError -> NetworkErrorDTO in
//                print(moyaError)
//                return moyaError.toNetworkError()
//            }
            .flatMap({ response -> AnyPublisher<Void, Error> in
                if (200..<300).contains(response.statusCode) {
                    return Empty().eraseToAnyPublisher()
                } else {
                    return Fail(error: ErrorVO.fatalError).eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
    
}

extension MoyaError {
    
    public func toNetworkError() -> NetworkErrorDTO {
        switch self {
            // Encoding Error
        case .encodableMapping(let error):
            return NetworkErrorDTO.encodeError(error)
        case .parameterEncoding(let error):
            return NetworkErrorDTO.encodeError(error)
            // Mapping Error
        case .imageMapping(let response):
            return NetworkErrorDTO.mappingError(response)
        case .jsonMapping(let response):
            return NetworkErrorDTO.mappingError(response)
        case .objectMapping(_, let response):
            return NetworkErrorDTO.mappingError(response)
        case .stringMapping(let response):
            return NetworkErrorDTO.mappingError(response)
        case .requestMapping(let string):
            return NetworkErrorDTO.requestError(string)
            // Underlying Error
        case .underlying(let error, let response):
            return NetworkErrorDTO.underlyingError(error, response)
            // StatusCode Error
        case .statusCode(let response):
            return NetworkErrorDTO.statusCode(response)
        }
    }
    
}
