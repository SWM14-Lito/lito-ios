//
//  ProblemSolvedDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct ProblemSolvedDTO: Decodable {
    let solved: Bool?
    
    func toVO() -> ProblemSolvedVO {
        return ProblemSolvedVO(solved: solved ?? false)
    }
}
