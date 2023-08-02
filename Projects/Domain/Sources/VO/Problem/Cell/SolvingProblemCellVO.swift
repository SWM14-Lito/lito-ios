//
//  SolvingProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct SolvingProblemCellVO: Hashable, ProblemCell {
    public let problemUserId: Int
    public let problemId: Int
    public let subjectName: String
    public let question: String
    public let problemStatus: ProblemSolvedStatus = .solving
    public var favorite: ProblemFavoriteStatus
    
    public init(problemUserId: Int, problemId: Int, subjectName: String, question: String, favorite: ProblemFavoriteStatus) {
        self.problemUserId = problemUserId
        self.problemId = problemId
        self.subjectName = subjectName
        self.question = question
        self.favorite = favorite
    }
}
