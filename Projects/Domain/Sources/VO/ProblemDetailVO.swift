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
    public let faqs: [ProblemFAQVO]?
    
    public init(question: String, answer: String, keyword: String, favorite: ProblemFavoriteStatus, faqs: [ProblemFAQVO]?) {
        self.question = question
        self.answer = answer
        self.keyword = keyword
        self.favorite = favorite
        self.faqs = faqs
    }
}

public struct ProblemFAQVO: Hashable {
    public let question: String
    public let answer: String
    
    public init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}
