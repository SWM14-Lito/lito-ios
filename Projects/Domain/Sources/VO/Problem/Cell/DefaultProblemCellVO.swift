//
//  ProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct DefaultProblemCellVO: Hashable, ProblemCell {
    
    public let problemId: Int
    public let subjectName: String
    public let question: String
    public var problemStatus: ProblemSolvedStatus
    public var favorite: ProblemFavoriteStatus
    
    public init(problemId: Int, subjectName: String, question: String, problemStatus: ProblemSolvedStatus, favorite: ProblemFavoriteStatus) {
        self.problemId = problemId
        self.subjectName = subjectName
        self.question = question
        self.problemStatus = problemStatus
        self.favorite = favorite
    }
}

extension DefaultProblemCellVO {
    public static var mock: DefaultProblemCellVO = .init(problemId: 0, subjectName: "Mock", question: "Mock", problemStatus: .unknown, favorite: .unknown)
}
