//
//  ProblemVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct LearningHomeVO {
    public let userInfo: LearningHomeUserInfoVO
    public let recommendedProblem: LearningHomeProblemVO?
    
    public init(userInfo: LearningHomeUserInfoVO, recommendedProblem: LearningHomeProblemVO?) {
        self.userInfo = userInfo
        self.recommendedProblem = recommendedProblem
    }
}

public struct LearningHomeUserInfoVO {
    public let userId: Int
    public let profileImgUrl: String?
    public let nickname: String
    
    public init(userId: Int, profileImgUrl: String?, nickname: String) {
        self.userId = userId
        self.profileImgUrl = profileImgUrl
        self.nickname = nickname
    }
}

public struct LearningHomeProblemVO {
    public let problemId: Int
    public let subject: String
    public let favorite: Bool
    
    public init(problemId: Int, subject: String, favorite: Bool) {
        self.problemId = problemId
        self.subject = subject
        self.favorite = favorite
    }
}
