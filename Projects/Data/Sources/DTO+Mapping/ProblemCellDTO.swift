//
//  ProblemCellDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct ProblemCellDTO: Decodable {
    let problemId: Int?
    let solved: String?
    let question: String?
    let subject: String?
    let favorite: Bool?
    
    func toVO() -> ProblemCellVO {
        return ProblemCellVO(problemId: problemId ?? 0, solved: ProblemSolvedStatus(rawValue: solved), question: question ?? "Unknown", subject: subject ?? "Unknown", favorite: ProblemFavoriteStatus(isFavorite: favorite))
    }
}
