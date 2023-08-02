//
//  ProblemCellDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain


struct VO {
    let problemUserId: Int?
    let favoriteId: Int?
    let problemId: Int?
    let subjectName: String
    let question: String
    let problemStatus: String
    let favorite: Bool
}

public struct ProblemCellDTO: Decodable {
    let problemUserId: Int?
    let favoriteId: Int?
    let problemId: Int?
    let subjectName: String?
    let question: String?
    let problemStatus: String?
    let favorite: Bool?
    
    func toProblemCellVO() -> DefaultProblemCellVO {
        return DefaultProblemCellVO(
            problemId: problemId ?? 0,
            subjectName: subjectName ?? "Unknown",
            question: question ?? "Unknown",
            problemStatus: ProblemSolvedStatus(rawValue: problemStatus),
            favorite: ProblemFavoriteStatus(isFavorite: favorite)
        )
    }
    
    func toSolvingProblemCellVO() -> SolvingProblemCellVO {
        return SolvingProblemCellVO(
            problemUserId: problemUserId ?? 0,
            problemId: problemId ?? 0,
            subjectName: subjectName ?? "Unknown",
            question: question ?? "Unknown",
            favorite: ProblemFavoriteStatus(isFavorite: favorite)
        )
    }
    
    func toFavoriteProblemCellVO() -> FavoriteProblemCellVO {
        return FavoriteProblemCellVO(
            favoriteId: favoriteId ?? 0,
            problemId: problemId ?? 0,
            subjectName: subjectName ?? "Unknown",
            question: question ?? "Unknown",
            problemStatus: ProblemSolvedStatus(rawValue: problemStatus)
        )
    }
}
