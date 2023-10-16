//
//  ProblemListVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/28.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct ProblemListVO {
    
    public let problemsCellVO: [DefaultProblemCellVO]?
    public let total: Int
    
    public init(problemsCellVO: [DefaultProblemCellVO]? = nil, total: Int) {
        self.problemsCellVO = problemsCellVO
        self.total = total
    }
}

extension ProblemListVO {
    public static func makeMock(start: Int, end: Int, total: Int) -> ProblemListVO {
        let defaultProblemCellVO = (start...end).map { num in
            DefaultProblemCellVO(problemId: num, subjectName: "Mock\(num)", question: "Mock\(num)", problemStatus: .unknown, favorite: .unknown)
        }
        return ProblemListVO(problemsCellVO: defaultProblemCellVO, total: total)
    }
}
