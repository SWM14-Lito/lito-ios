//
//  ProblemMutableVO.swift
//  Domain
//
//  Created by 김동락 on 2023/08/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ProblemMutableVO {
    public let problemId: Int
    public let problemStatus: ProblemSolvedStatus
    public var favorite: ProblemFavoriteStatus
    
    public init(problemId: Int, problemStatus: ProblemSolvedStatus, favorite: ProblemFavoriteStatus) {
        self.problemId = problemId
        self.problemStatus = problemStatus
        self.favorite = favorite
    }
}
