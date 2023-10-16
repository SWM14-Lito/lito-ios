//
//  ChatDataSource.swift
//  Data
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Domain

public protocol ChatDataSource {
    func sendQuestion(sendingQuestionDTO: SendingQuestionDTO) -> AnyPublisher<ChatGPTAnswerDTO, Error>
}

final public class DefaultChatDataSource: ChatDataSource {
    
    public init() {}
    
    private let moyaProvider = MoyaWrapper<ChatAPI>()
    
    public func sendQuestion(sendingQuestionDTO: SendingQuestionDTO) -> AnyPublisher<ChatGPTAnswerDTO, Error> {
        moyaProvider.call(target: .chattingWithChatCPT(sendingQuestionDTO))
    }

}
