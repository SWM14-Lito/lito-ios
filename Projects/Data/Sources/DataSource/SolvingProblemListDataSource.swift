//
//  SolvingProblemDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol SolvingProblemListDataSource {
    func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<ProblemsDTO, Error>
}

final public class DefaultSolvingProblemListDataSource: SolvingProblemListDataSource {
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ProblemAPI>()
    
    public func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<ProblemsDTO, Error> {
        moyaProvider.call(target: .solvingProblemList(problemsQueryDTO))
    }
}
