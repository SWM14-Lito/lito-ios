//
//  DialogueCellVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/28.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct DialogueUnitVO: Hashable {
    
    public let text: String
    public let dialogueType: DialogueType
    
    public init(text: String = "", dialogueType: DialogueType) {
        self.text = text
        self.dialogueType = dialogueType
    }
}

public enum DialogueType {
    case fromChatGPT
    case fromChatGPTWaiting
    case fromChatGPTFail
    case fromUser
}
