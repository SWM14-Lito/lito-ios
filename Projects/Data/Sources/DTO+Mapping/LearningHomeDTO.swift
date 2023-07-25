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
    let question: String?
    let problemId: Int?
    let subject: String?
    let favorite: Bool?

    func toVO() -> LearningHomeVO {
        let userInfo = LearningHomeUserInfoDTO(userId: userId, profileImgUrl: profileImgUrl, nickname: nickname).toVO()
        let problemInfo: ProblemCellVO?
        
        if let problemId = problemId {
            problemInfo = ProblemCellDTO(problemId: problemId, solved: "풀이중", question: question, subject: subject, favorite: favorite).toVO()
        } else {
            problemInfo = nil
        }
        
        return LearningHomeVO(userInfo: userInfo, solvingProblem: problemInfo)
    }
}

public struct LearningHomeUserInfoDTO {
    let userId: Int
    let profileImgUrl: String?
    let nickname: String?
    
    func toVO() -> LearningHomeUserInfoVO {
        return LearningHomeUserInfoVO(userId: userId, profileImgUrl: profileImgUrl, nickname: nickname ?? "Unkown")
    }
}

#if DEBUG
extension LearningHomeDTO: Encodable {}
#endif
