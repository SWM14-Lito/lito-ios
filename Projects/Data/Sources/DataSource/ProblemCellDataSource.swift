//
//  ProblemCellDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol ProblemCellDataSource {
    
}

final public class DefaultProblemCellDataSource: ProblemCellDataSource {

    public init() {}
    
    private let moyaProvider = MoyaWrapper<LearningHomeAPI>()
}
