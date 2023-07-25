//
//  SovingProblemUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol SolvingProblemListUseCase {
    func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<[SolvingProblemCellVO]?, Error>
}

public final class DefaultSolvingProblemListUseCase: SolvingProblemListUseCase {
    private let repository: SolvingProblemListRepository
    
    public init(repository: SolvingProblemListRepository) {
        self.repository = repository
    }
    
    public func getProblemList(problemsQueryDTO: SolvingProblemsQueryDTO) -> AnyPublisher<[SolvingProblemCellVO]?, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
}
