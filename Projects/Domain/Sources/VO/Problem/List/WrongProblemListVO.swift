//
//  ReviewNoteListVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct WrongProblemListVO {
    
    public let problemsCellVO: [WrongProblemCellVO]?
    public let total: Int
    
    public init(problemsCellVO: [WrongProblemCellVO]? = nil, total: Int) {
        self.problemsCellVO = problemsCellVO
        self.total = total
    }
}
