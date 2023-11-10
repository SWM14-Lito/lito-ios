//
//  WrongProblemCellVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct WrongProblemCellVO: Hashable, ProblemCell {
    
    public let problemId: Int
    public let subjectName: String
    public let question: String
    public var problemStatus: ProblemSolvedStatus = .solving
    public var favorite: ProblemFavoriteStatus
    public let unsolvedCnt: Int
    
    public init(problemId: Int, subjectName: String, question: String, problemStatus: ProblemSolvedStatus, favorite: ProblemFavoriteStatus, unsolvedCnt: Int) {
        self.problemId = problemId
        self.subjectName = subjectName
        self.question = question
        self.problemStatus = problemStatus
        self.favorite = favorite
        self.unsolvedCnt = unsolvedCnt
    }
}
