//
//  QuestionDataSource.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol ProblemListDataSource {
    func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemsDTO, Error>
}

final public class DefaultProblemListDataSource: ProblemListDataSource {

    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProblemAPI>()
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemsDTO, Error> {
        moyaProvider.call(target: .problemList(problemsQueryDTO))
    }
}
