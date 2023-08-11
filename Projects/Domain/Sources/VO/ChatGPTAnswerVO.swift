//
//  ChatGPTAnswerVO.swift
//  Domain
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ChatGPTAnswerVO {
    public let id: String
    public let object: String
    public let created: Int
    public let model: String
    public let messages: [ChatGPTMessageVO]
    public let usage: ChatGPTUsageVO
    
    public init(id: String, object: String, created: Int, model: String, messages: [ChatGPTMessageVO], usage: ChatGPTUsageVO) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.messages = messages
        self.usage = usage
    }
}

public struct ChatGPTMessageVO {
    public let role: String
    public let message: String
    
    public init(role: String, message: String) {
        self.role = role
        self.message = message
    }
}

public struct ChatGPTUsageVO {
    public let promptTokens: Int
    public let completionTokens: Int
    public let totalTokens: Int
    
    public init(promptTokens: Int, completionTokens: Int, totalTokens: Int) {
        self.promptTokens = promptTokens
        self.completionTokens = completionTokens
        self.totalTokens = totalTokens
    }
}
