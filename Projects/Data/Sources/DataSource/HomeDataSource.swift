//
//  HomeDataSource.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import CombineMoya
import Moya

public protocol HomeDataSource {
    func loadMaxim() -> AnyPublisher<SlipDTO, NetworkErrorDTO>
}

public class DefaultHomeDataSource: HomeDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<APIService>()
    
    public func loadMaxim() -> AnyPublisher<SlipDTO, NetworkErrorDTO> {
        return moyaProvider.call(target: .oneSlip)
            .eraseToAnyPublisher()
    }
    
}
