//
//  SolvingProblemsQueryDTO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct SolvingProblemsQueryDTO {
    public let lastProblemUserId: Int?
    public let size: String?
    
    public init(lastProblemUserId: Int? = nil, size: String? = nil) {
        self.lastProblemUserId = lastProblemUserId
        self.size = size
    }
}
