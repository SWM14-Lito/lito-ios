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
    
    func call<Value>(target: Provider) -> AnyPublisher<Value, NetworkErrorDTO> where Value: Decodable {
        return self.requestPublisher(target)
            .map(Value.self)
            .mapError { moyaError -> NetworkErrorDTO in
                return moyaError.toNetworkError()
            }
            .eraseToAnyPublisher()
    }
    
}
