//
//  ProblemListUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemListUseCase {
    func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error>
}

public final class DefaultProblemListUseCase: ProblemListUseCase {
    
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
    
}
