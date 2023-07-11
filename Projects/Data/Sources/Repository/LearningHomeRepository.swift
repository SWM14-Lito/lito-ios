//
//  LearningHomeRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

final public class DefaultLearningHomeRepository: LearningHomeRepository {
    
    let dataSource: LearningHomeDataSource
    
    public init(dataSource: LearningHomeDataSource) {
        self.dataSource = dataSource
    }
}
