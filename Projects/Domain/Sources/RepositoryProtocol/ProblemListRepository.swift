//
//  ProblemListRepository.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemListRepository {
    func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<[ProblemCellVO]?, Error>
}
