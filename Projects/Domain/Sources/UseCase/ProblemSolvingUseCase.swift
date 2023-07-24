//
//  ProblemSolvingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol ProblemSolvingUseCase {
    func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error>
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func showAnswer()
    func correct()
    func wrong()
}

public final class DefaultProblemSolvingUseCase: ProblemSolvingUseCase {
    
    private let repository: ProblemSolvingRepository
    
    public init(repository: ProblemSolvingRepository) {
        self.repository = repository
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        repository.getProblemDetail(id: id)
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func showAnswer() {
        
    }
    
    public func handleInput() {
        
    }
    
    public func correct() {
        
    }
    
    public func wrong() {
        
    }
}
