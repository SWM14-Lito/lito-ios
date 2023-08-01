//
//  ProblemSolvingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol ProblemDetailUseCase {
    func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error>
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error>
    func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error>
    func showAnswer()
}

public final class DefaultProblemDetailUseCase: ProblemDetailUseCase {
    
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        repository.getProblemDetail(id: id)
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        repository.startSolvingProblem(id: id)
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error> {
        repository.submitAnswer(id: id, keyword: keyword)
    }
    
    public func showAnswer() {
        
    }

}
