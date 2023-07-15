//
//  ProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ProblemCellVO {
    public let problemId: Int
    public let solved: String
    public let question: String
    public let subject: String
    // var로 정의한 이유: favorite (찜하기 여부) 는 누를 때마다 토글되는 값이기 때문
    // 하지만 VO는 불변값으로 알고 있어서 let으로 선언되어야 할 듯 한데, 이럴 경우 어떻게 해야할지?
    public var favorite: Bool
    
    public init(problemId: Int, solved: String, question: String, subject: String, favorite: Bool) {
        self.problemId = problemId
        self.solved = solved
        self.question = question
        self.subject = subject
        self.favorite = favorite
    }
}
