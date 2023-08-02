//
//  FavoriteProblemCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct FavoriteProblemCellVO: Hashable, ProblemCell {
    public let favoriteId: Int
    public let problemId: Int
    public let subjectName: String
    public let question: String
    public let problemStatus: ProblemSolvedStatus
    public var favorite: ProblemFavoriteStatus = .favorite
    
    public init(favoriteId: Int, problemId: Int, subjectName: String, question: String, problemStatus: ProblemSolvedStatus) {
        self.favoriteId = favoriteId
        self.problemId = problemId
        self.subjectName = subjectName
        self.question = question
        self.problemStatus = problemStatus
    }
}
