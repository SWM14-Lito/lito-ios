//
//  SolvingProblemsQueryDTO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct SolvingProblemsQueryDTO {
    public let lastProblemUserId: Int?
    public let page: Int
    public let size: Int
    
    public init(lastProblemUserId: Int?, page: Int, size: Int) {
        self.lastProblemUserId = lastProblemUserId
        self.page = page
        self.size = size
    }
}
