//
//  LearningHomeUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol LearningHomeUseCase {
    func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error>
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
}

public final class DefaultLearningHomeUseCase: LearningHomeUseCase {
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error> {
         repository.getProfileAndProblems()
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
}
