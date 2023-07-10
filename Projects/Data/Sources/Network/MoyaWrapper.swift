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
                #if DEBUG
                print(moyaError.errorDescription ?? moyaError)
                #endif
                return moyaError.toNetworkError()
            }
            .eraseToAnyPublisher()
    }
    
    func call(target: Provider) -> AnyPublisher<Void, Error> {
        return self.requestPublisher(target)
            .catch({ moyaError -> Fail in
                #if DEBUG
                print(moyaError.errorDescription ?? moyaError)
                #endif
                return Fail(error: ErrorVO.fatalError)
            })
            .flatMap({ response -> AnyPublisher<Void, Error> in
                if (200..<300).contains(response.statusCode) {
                    return Just(()).setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: ErrorVO.fatalError).eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
    
}
