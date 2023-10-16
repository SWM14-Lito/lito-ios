//
//  ProblemCellDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct ProblemCellDTO: Decodable {
    let problemUserId: Int?
    let favoriteId: Int?
    let problemId: Int?
    let subjectName: String?
    let question: String?
    let problemStatus: String?
    let favorite: Bool?
    
    func toProblemCellVO() -> DefaultProblemCellVO? {
        if let problemId = problemId {
            return DefaultProblemCellVO(
                problemId: problemId,
                subjectName: subjectName ?? "Unknown",
                question: question ?? "Unknown",
                problemStatus: ProblemSolvedStatus(rawValue: problemStatus),
                favorite: ProblemFavoriteStatus(isFavorite: favorite)
            )
        } else {
            return nil
        }
    }
    
    func toSolvingProblemCellVO() -> SolvingProblemCellVO? {
        if let problemId = problemId {
            return SolvingProblemCellVO(
                problemUserId: problemUserId ?? 0,
                problemId: problemId,
                subjectName: subjectName ?? "Unknown",
                question: question ?? "Unknown",
                favorite: ProblemFavoriteStatus(isFavorite: favorite)
            )
        } else {
            return nil
        }
    }
    
    func toFavoriteProblemCellVO() -> FavoriteProblemCellVO? {
        if let problemId = problemId {
            return FavoriteProblemCellVO(
                favoriteId: favoriteId ?? 0,
                problemId: problemId,
                subjectName: subjectName ?? "Unknown",
                question: question ?? "Unknown",
                problemStatus: ProblemSolvedStatus(rawValue: problemStatus)
            )
        } else {
            return nil
        }
    }
}

#if DEBUG
extension ProblemCellDTO: Encodable {}
#endif
