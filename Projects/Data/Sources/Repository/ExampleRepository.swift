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
            .catch { error -> Fail in
                if let moyaError = error as? MoyaError {
                    #if DEBUG
                    let networkError = moyaError.toNetworkError()
                    print(networkError.debugString)
                    #endif
                    return Fail(error: networkError)
                }
                return Fail(error: ErrorVO.fatalError)
            }
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
}
