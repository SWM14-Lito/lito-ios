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
    
    public func loadSlip() -> AnyPublisher<SlipVO, NetworkErrorVO> {
        return dataSource.loadMaxim()
            .mapError { networkErrorDTO -> NetworkErrorVO in
                #if DEBUG
                print(networkErrorDTO.debugString)
                #endif
                return networkErrorDTO.toVO()
            }
            .flatMap { value -> AnyPublisher<SlipVO, NetworkErrorVO> in
                Just(value.toVO())
                    .setFailureType(to: NetworkErrorVO.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
