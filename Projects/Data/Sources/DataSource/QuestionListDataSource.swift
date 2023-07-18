//
//  QuestionDataSource.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol QuestionListDataSource {
    func getProfileAndProblems() -> AnyPublisher<LearningHomeDTO, Error>
}

final public class DefaultQuestionListDataSource: QuestionListDataSource {

    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProblemAPI>()
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeDTO, Error> {
        moyaProvider.call(target: .learningHome)
    }
}
