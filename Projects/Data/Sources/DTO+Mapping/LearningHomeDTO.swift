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
    let processProblem: ProblemCellDTO?
    let recommendProblems: [ProblemCellDTO]?

    func toVO() -> LearningHomeVO {
       return LearningHomeVO(
        userId: userId,
        profileImgUrl: profileImgUrl,
        nickname: nickname ?? "Unknown",
        processProblem: processProblem?.toProblemCellVO(),
        recommendProblems: recommendProblems?.compactMap { $0.toProblemCellVO() } ?? []
       )
    }
}

#if DEBUG
extension LearningHomeDTO: Encodable {}
#endif
