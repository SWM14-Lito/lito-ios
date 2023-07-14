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
    
    let dataSource: LearningHomeDataSource
    
    public init(dataSource: LearningHomeDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error> {
        dataSource.getProfileAndProblems()
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
