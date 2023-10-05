//
//  sendingQuestionDTO.swift
//  Domain
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct SendingQuestionDTO {
    public let message: String
    public let problemId: Int
    
    public init(message: String, problemId: Int) {
        self.message = message
        self.problemId = problemId
    }
}
