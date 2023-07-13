//
//  LearningHomeDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct LearningHomeDTO: Decodable {
    let userId: Int
    let profileImgUrl: String?
    let nickname: String?
    let problemId: Int?
    let subject: String?
    let favorite: Bool?

    func toVO() -> LearningHomeVO {
        let userInfo = LearningHomeUserInfoVO(userId: userId, profileImgUrl: profileImgUrl, nickname: nickname ?? "Unknown")
        let problemInfo: LearningHomeProblemVO?
        if let problemId = problemId,
           let subject = subject {
            problemInfo = LearningHomeProblemVO(problemId: problemId, subject: subject, favorite: favorite ?? false)
        } else {
            problemInfo = nil
        }
        return LearningHomeVO(userInfo: userInfo, recommendedProblem: problemInfo)
    }
}
