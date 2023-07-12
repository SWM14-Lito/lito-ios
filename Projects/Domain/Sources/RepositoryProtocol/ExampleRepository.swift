//
//  HomeRepository.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Combine

public protocol ExampleRepository {
    func loadSlip() -> AnyPublisher<SlipVO, Error>
}
