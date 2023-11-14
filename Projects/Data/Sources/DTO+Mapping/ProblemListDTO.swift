//
//  ProblemsDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

import Domain

public struct ProblemListDTO: Decodable {
    let problems: [ProblemCellDTO]?
    let total: Int
    
    func toProblemListVO() -> ProblemListVO {
        let problems = problems?.compactMap { $0.toProblemCellVO() }
        return ProblemListVO(problemsCellVO: problems, total: total)
    }
    
    func toSolvingProblemListVO() -> SolvingProblemListVO {
        let problems = problems?.compactMap { $0.toSolvingProblemCellVO() }
        return SolvingProblemListVO(problemsCellVO: problems, total: total)
    }
    
    func toFavoriteProblemListVO() -> FavoriteProblemListVO {
        let problems = problems?.compactMap { $0.toFavoriteProblemCellVO() }
        return FavoriteProblemListVO(problemsCellVO: problems, total: total)
    }
    
    func toWrongProblemListVO() -> WrongProblemListVO {
        let problems = problems?.compactMap { $0.toWrongProblemCellVO() }
        return WrongProblemListVO(problemsCellVO: problems, total: total)
    }
}

#if DEBUG
extension ProblemListDTO: Encodable {}
#endif
