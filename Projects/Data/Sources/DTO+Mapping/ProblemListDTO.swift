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
    
    func toVO() -> ProblemListVO {
        let problems = problems?.map { $0.toVO() }
        return ProblemListVO(problemsCellVO: problems, total: total)
    }
}
