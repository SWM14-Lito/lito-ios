//
//  LearningHomeRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine
import Moya

final public class DefaultLearningHomeRepository: LearningHomeRepository {
    
    private let dataSource: LearningHomeDataSource
    
    public init(dataSource: LearningHomeDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error> {
        dataSource.getProfileAndProblems()
            .map { $0.toVO() }
            .eraseToAnyPublisher()
    }
}
