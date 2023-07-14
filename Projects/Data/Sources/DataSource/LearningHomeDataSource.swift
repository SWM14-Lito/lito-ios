//
//  LearningHomeDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol LearningHomeDataSource {
    func getProfileAndProblems() -> AnyPublisher<LearningHomeDTO, Error>
}

final public class DefaultLearningHomeDataSource: LearningHomeDataSource {

    public init() {}
    
    private let moyaProvider = MoyaWrapper<LearningHomeAPI>()
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeDTO, Error> {
        moyaProvider.call(target: .getProfileAndProblems)
    }
}
