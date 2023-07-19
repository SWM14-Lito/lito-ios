//
//  ProblemDetailVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ProblemDetailVO {
    public let question: String
    public let answer: String
    public let keyword: String
    public var favorite: ProblemFavoriteStatus
    
    public init(question: String, answer: String, keyword: String, favorite: ProblemFavoriteStatus) {
        self.question = question
        self.answer = answer
        self.keyword = keyword
        self.favorite = favorite
    }
}
