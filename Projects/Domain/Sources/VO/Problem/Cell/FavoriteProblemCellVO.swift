//
//  FavoriteProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct FavoriteProblemCellVO: Hashable {
    
    public let favoriteId: Int
    public let problemCellVO: ProblemCellVO
    
    public init(favoriteId: Int, problemCellVO: ProblemCellVO) {
        self.favoriteId = favoriteId
        self.problemCellVO = problemCellVO
    }
}
