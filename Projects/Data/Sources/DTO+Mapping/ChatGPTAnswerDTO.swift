//
//  ChatGPTAnswerDTO.swift
//  Data
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct ChatGPTAnswerDTO: Decodable {
    let id: String?
    let object: String?
    let created: Int?
    let model: String?
    let messages: [ChatGPTMessageDTO]?
    let usage: ChatGPTUsageDTO?
    
    func toVO() -> ChatGPTAnswerVO {
        return ChatGPTAnswerVO(
            id: id ?? "Unknown",
            object: object ?? "Unknown",
            created: created ?? -1,
            model: model ?? "Unknown",
            messages: messages?.map { $0.toVO() } ?? [],
            usage: usage?.toVO() ?? ChatGPTUsageDTO(promptTokens: nil, completionTokens: nil, totalTokens: nil).toVO()
        )
    }
}

public struct ChatGPTMessageDTO: Decodable {
    let role: String?
    let message: String?
    
    func toVO() -> ChatGPTMessageVO {
        return ChatGPTMessageVO(
            role: role ?? "Unknown",
            message: message ?? "Unknown"
        )
    }
}

public struct ChatGPTUsageDTO: Decodable {
    let promptTokens: Int?
    let completionTokens: Int?
    let totalTokens: Int?
    
    func toVO() -> ChatGPTUsageVO {
        return ChatGPTUsageVO(
            promptTokens: promptTokens ?? -1,
            completionTokens: completionTokens ?? -1,
            totalTokens: totalTokens ?? -1
        )
    }
}
