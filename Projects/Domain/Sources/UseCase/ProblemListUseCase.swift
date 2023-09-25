//
//  ProblemListUseCase.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ProblemListUseCase {
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error>
}

public final class DefaultProblemListUseCase: ProblemListUseCase {
    
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error> {
        repository.getProblemList(problemsQueryDTO: problemsQueryDTO)
    }
}

public final class MockProblemListUseCase: ProblemListUseCase {
    
    private var toggleProblemFavoriteResponse: AnyPublisher<Void, Error> =
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    
    private var getProblemListResponse: AnyPublisher<ProblemListVO, Error> = {
        let problemListVO = ProblemListVO.makeMock(start: 0, end: 9, total: 20)
        return Just(problemListVO)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }()
    
    public init() {}
    
    public func setGetProblemListResponse(_ response: AnyPublisher<ProblemListVO, Error>) {
        self.getProblemListResponse = response
    }
    
    public func setToggleProblemFavoriteResponse(_ response: AnyPublisher<Void, Error>) {
        self.toggleProblemFavoriteResponse = response
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        toggleProblemFavoriteResponse
    }
    
    public func getProblemList(problemsQueryDTO: ProblemsQueryDTO) -> AnyPublisher<ProblemListVO, Error> {
        getProblemListResponse
    }
    
}
