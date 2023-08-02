//
//  ProblemVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct LearningHomeVO {
    public let userInfo: LearningHomeUserInfoVO
    public var solvingProblem: DefaultProblemCellVO? // favorite 값이 바뀔 수 있기 때문에 var로 선언
    
    public init(userInfo: LearningHomeUserInfoVO, solvingProblem: DefaultProblemCellVO?) {
        self.userInfo = userInfo
        self.solvingProblem = solvingProblem
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
