//
//  ProblemListUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemListUseCase {
    func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<[ProblemCellVO]?, Error>
}

public final class DefaultProblemListUseCase: ProblemListUseCase {
    
    private let repository: ProblemListRepository
    
    public init(repository: ProblemListRepository) {
        self.repository = repository
    }
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<[ProblemCellVO]?, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
    
}
