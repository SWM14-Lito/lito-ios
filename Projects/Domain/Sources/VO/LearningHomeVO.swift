//
//  ProblemVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct LearningHomeVO {
    public let userId: Int
    public let profileImgUrl: String?
    public let nickname: String
    public var processProblem: DefaultProblemCellVO?
    public var recommendProblems: [DefaultProblemCellVO]
    
    public init(userId: Int, profileImgUrl: String?, nickname: String, processProblem: DefaultProblemCellVO?, recommendProblems: [DefaultProblemCellVO]) {
        self.userId = userId
        self.profileImgUrl = profileImgUrl
        self.nickname = nickname
        self.processProblem = processProblem
        self.recommendProblems = recommendProblems
    }
}
