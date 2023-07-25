//
//  ProblemSolvedVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ProblemSolvedVO: Hashable {
    
    public let solved: Bool
    
    public init(solved: Bool) {
        self.solved = solved
    }
}
