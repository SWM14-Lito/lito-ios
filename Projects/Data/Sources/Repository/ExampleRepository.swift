//
//  ExampleRepository.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Combine
import Foundation
import Domain
import Moya

final public class DefaultExampleRepository: ExampleRepository {
    let dataSource: ExampleDataSource
    
    public init(dataSource: ExampleDataSource) {
        self.dataSource = dataSource
    }
    
    public func loadSlip() -> AnyPublisher<SlipVO, Error> {
        return dataSource.loadMaxim()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
}
