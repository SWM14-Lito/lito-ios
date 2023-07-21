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
}

public final class DefaultLearningHomeUseCase: LearningHomeUseCase {
    private let repository: LearningHomeRepository
    
    public init(repository: LearningHomeRepository) {
        self.repository = repository
    }
    
    public func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error> {
        // repository.getProfileAndProblems()
        
        MockData.getMockData(data: MockData.learningHomeVO)
    }
}
