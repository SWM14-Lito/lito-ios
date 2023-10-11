//
//  LearningHomeUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation
import SWMLogging

public protocol LearningHomeUseCase {
    func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error>
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func setProblemGoalCount(problemGoalCount: Int)
    func getProblemGoalCount() -> Int
    func fireLogging(scheme: SWMLogging.SWMLoggingScheme)
}

public final class DefaultLearningHomeUseCase: LearningHomeUseCase {
    private let repository: ProblemRepository
    private let logger: SWMLogger
    
    public init(repository: ProblemRepository, logger: SWMLogger) {
        self.repository = repository
        self.logger = logger
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error> {
         repository.getProfileAndProblems()
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func setProblemGoalCount(problemGoalCount: Int) {
        repository.setProblemGoalCount(problemGoalCount: problemGoalCount)
    }
    
    public func getProblemGoalCount() -> Int {
        repository.getProblemGoalCount()
    }
    public func fireLogging(scheme: SWMLogging.SWMLoggingScheme) {
        do {
            try logger.shotLogging(scheme, authorization: KeyChainManager.read(key: .accessToken) ?? "")
        } catch {
            
        }
    }
}
