//
//  SolvingProblemListVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct SolvingProblemListVO {
    
    public let problemsCellVO: [SolvingProblemCellVO]?
    public let total: Int
    
    public init(problemsCellVO: [SolvingProblemCellVO]? = nil, total: Int) {
        self.problemsCellVO = problemsCellVO
        self.total = total
    }
}
