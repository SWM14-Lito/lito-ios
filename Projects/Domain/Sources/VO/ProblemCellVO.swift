//
//  ProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ProblemCellVO {
    public let problemId: Int
    public let solved: ProblemSolvedStatus
    public let question: String
    public let subject: String
    public var favorite: ProblemFavoriteStatus
    
    public init(problemId: Int, solved: ProblemSolvedStatus, question: String, subject: String, favorite: ProblemFavoriteStatus) {
        self.problemId = problemId
        self.solved = solved
        self.question = question
        self.subject = subject
        self.favorite = favorite
    }
}
