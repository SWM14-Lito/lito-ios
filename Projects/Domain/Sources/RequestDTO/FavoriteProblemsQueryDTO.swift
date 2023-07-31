//
//  SolvingProblemsQueryDTO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct FavoriteProblemsQueryDTO {
    public let lastFavoriteId: Int?
    public let subjectId: Int?
    public let problemStatus: String?
    public let size: String?
    
    public init(lastFavoriteId: Int? = nil, subjectId: Int? = nil, problemStatus: String? = nil, size: String? = nil) {
        self.lastFavoriteId = lastFavoriteId
        self.subjectId = subjectId
        self.problemStatus = problemStatus
        self.size = size
    }
}
