//
//  SolvingProblemRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol SolvingProblemListRepository {
    func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<SolvingProblemListVO, Error>
}
