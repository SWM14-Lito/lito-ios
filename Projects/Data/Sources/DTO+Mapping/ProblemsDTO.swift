//
//  ProblemsDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/24.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

import Domain

public struct ProblemsDTO: Decodable {
    let problems: [ProblemCellDTO]?
    
    func toVO() -> [ProblemCellVO]? {
        return problems?.map { $0.toVO() }
    }
}
