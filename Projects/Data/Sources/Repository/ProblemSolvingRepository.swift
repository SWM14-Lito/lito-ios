//
//  ProblemSolvingRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

final public class DefaultProblemSolvingRepository: ProblemSolvingRepository {
    
    private let dataSource: ProblemSolvingDataSource
    
    public init(dataSource: ProblemSolvingDataSource) {
        self.dataSource = dataSource
    }
}
