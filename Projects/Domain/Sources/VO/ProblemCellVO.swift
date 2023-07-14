//
//  ProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

// 명칭 서버와 협의 필요
public struct ProblemCellVO {
    public let problemId: Int
    public let solved: String
    public let question: String
    public let subject: String
    public var favorite: Bool
    
    public init(problemId: Int, solved: String, question: String, subject: String, favorite: Bool) {
        self.problemId = problemId
        self.solved = solved
        self.question = question
        self.subject = subject
        self.favorite = favorite
    }
}
