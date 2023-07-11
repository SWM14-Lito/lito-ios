//
//  LearningHomeUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public protocol LearningHomeUseCase {

}

public final class DefaultLearningHomeUseCase: LearningHomeUseCase {
    let repository: LearningHomeRepository
    
    public init(repository: LearningHomeRepository) {
        self.repository = repository
    }
}
