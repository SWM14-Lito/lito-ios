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
//    func getProblemInfo() -> AnyPublisher<ProblemDetailVO, Error>
    func showAnswer()
    func toggleFavorite()
    func correct()
    func wrong()
}

public final class DefaultProblemSolvingUseCase: ProblemSolvingUseCase {
    
    private let repository: ProblemSolvingRepository
    
    public init(repository: ProblemSolvingRepository) {
        self.repository = repository
    }
    
//    public func getProblemInfo() -> AnyPublisher<ProblemDetailVO, Error> {
//
//    }
    
    public func showAnswer() {
        
    }
    
    public func toggleFavorite() {
        
    }
    
    public func handleInput() {
        
    }
    
    public func correct() {
        
    }
    
    public func wrong() {
        
    }
}
