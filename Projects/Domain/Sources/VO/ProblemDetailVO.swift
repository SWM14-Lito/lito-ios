//
//  ProblemDetailVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

// 서버 API 명세 나오면 변수명 수정 및 추가하기
public struct ProblemDetailVO {
    public let question: String
    public let answer: String
    public let keyword: String
    
    public init(question: String, answer: String, keyword: String) {
        self.question = question
        self.answer = answer
        self.keyword = keyword
    }
}
