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
    public let page: Int
    public let size: Int
    
    public init(lastFavoriteId: Int?, subjectId: Int?, problemStatus: String?, page: Int, size: Int) {
        self.lastFavoriteId = lastFavoriteId
        self.subjectId = subjectId
        self.problemStatus = problemStatus
        self.page = page
        self.size = size
    }
}
