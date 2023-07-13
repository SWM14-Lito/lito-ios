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

    // 서버와 명칭 협의 필요
    func toVO() -> LearningHomeVO {
        let userInfo = LearningHomeUserInfoVO(userId: userId, profileImgUrl: profileImgUrl, nickname: nickname ?? "Unknown")
        let problemInfo: ProblemCellVO?
        if let problemId = problemId {
            problemInfo = ProblemCellVO(problemId: problemId, solved: "풀이중", title: "문제제목", subject: subject ?? "Unknown", favorite: favorite ?? false)
        } else {
            problemInfo = nil
        }
        return LearningHomeVO(userInfo: userInfo, recommendedProblem: problemInfo)
    }
}
