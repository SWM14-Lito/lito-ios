//
//  ExampleRepository.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Combine
import Domain

final public class DefaultExampleRepository: ExampleRepository {
    private let dataSource: ExampleDataSource
    
    public init(dataSource: ExampleDataSource) {
        self.dataSource = dataSource
    }
    
    public func loadSlip() -> AnyPublisher<SlipVO, Error> {
        dataSource.loadMaxim()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
}
