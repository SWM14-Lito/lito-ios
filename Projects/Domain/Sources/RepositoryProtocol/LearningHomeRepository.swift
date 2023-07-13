//
//  LearningHomeRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/07/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol LearningHomeRepository {
    func getProfileAndProblems() -> AnyPublisher<LearningHomeVO, Error>
}
