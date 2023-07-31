//
//  ProblemListRepository.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine

final public class DefaultProblemListRepository: ProblemListRepository {
    
    private let dataSource: ProblemListDataSource
    
    public init(dataSource: ProblemListDataSource) {
        self.dataSource = dataSource
    }
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error> {
        dataSource.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .map { $0.toProblemCellVO() }
            .eraseToAnyPublisher()
    }
    
}
