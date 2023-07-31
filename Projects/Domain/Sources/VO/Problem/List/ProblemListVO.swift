//
//  ProblemListVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/28.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct ProblemListVO {
    
    public let problemsCellVO: [ProblemCellVO]?
    public let total: Int
    
    public init(problemsCellVO: [ProblemCellVO]? = nil, total: Int) {
        self.problemsCellVO = problemsCellVO
        self.total = total
    }
}
