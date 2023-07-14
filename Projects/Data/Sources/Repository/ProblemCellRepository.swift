//
//  ProblemCellRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

final public class DefaultProblemCellRepository: ProblemCellRepository {
    let dataSource: ProblemCellDataSource
    
    public init(dataSource: ProblemCellDataSource) {
        self.dataSource = dataSource
    }
}
