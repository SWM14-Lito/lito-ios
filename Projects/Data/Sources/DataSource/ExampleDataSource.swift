//
//  ExampleDataSource.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine
import CombineMoya
import Moya

public protocol ExampleDataSource {
    func loadMaxim() -> AnyPublisher<SlipDTO, Error>
}

final public class DefaultExampleDataSource: ExampleDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<APIService>()
    
    public func loadMaxim() -> AnyPublisher<SlipDTO, Error> {
        return moyaProvider.call(target: .oneSlip)
    }
    
}
