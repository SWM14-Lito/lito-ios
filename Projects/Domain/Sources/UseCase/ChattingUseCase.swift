//
//  ChattingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol ChattingUseCase {
    func sendQuestion(sendingQuestionDTO: SendingQuestionDTO) -> AnyPublisher<ChatGPTAnswerVO, Error>
}

public final class DefaultChattingUseCase: ChattingUseCase {
    private let repository: ChatRepository
    
    public init(repository: ChatRepository) {
        self.repository = repository
    }
    
    public func sendQuestion(sendingQuestionDTO: SendingQuestionDTO) -> AnyPublisher<ChatGPTAnswerVO, Error> {
        repository.sendQuestion(sendingQuestionDTO: sendingQuestionDTO)
    }
}
