//
//  ReviewNoteListUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol WrongProblemListUseCase {
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func getProblemList(problemsQueryDTO: WrongProblemQueryDTO) -> AnyPublisher<WrongProblemListVO, Error>
}

public final class DefaultWrongProblemListUseCase: WrongProblemListUseCase {
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func getProblemList(problemsQueryDTO: WrongProblemQueryDTO) -> AnyPublisher<WrongProblemListVO, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
}
