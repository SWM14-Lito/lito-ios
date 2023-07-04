//
//  HomeRepository.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Combine
import Foundation
import Domain

final public class DefaultHomeRepository: HomeRepository {
    let dataSource: HomeDataSource
    
    public init(dataSource: HomeDataSource) {
        self.dataSource = dataSource
    }
    
    public func loadSlip() -> AnyPublisher<SlipVO, ErrorVO> {
        return dataSource.loadMaxim()
            .mapError { networkErrorDTO -> ErrorVO in
                #if DEBUG
                print(networkErrorDTO.debugString)
                #endif
                return networkErrorDTO.toVO()
            }
            .flatMap { value -> AnyPublisher<SlipVO, ErrorVO> in
                Just(value.toVO())
                    .setFailureType(to: ErrorVO.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
