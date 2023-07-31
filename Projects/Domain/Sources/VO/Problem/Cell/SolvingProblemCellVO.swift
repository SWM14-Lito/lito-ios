//
//  SolvingProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct SolvingProblemCellVO: Hashable {
    
    public let problemUserId: Int
    public let problemCellVO: ProblemCellVO
    
    public init(problemUserId: Int, problemCellVO: ProblemCellVO) {
        self.problemUserId = problemUserId
        self.problemCellVO = problemCellVO
    }
}
