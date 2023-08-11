//
//  ChatRepository.swift
//  Domain
//
//  Created by 김동락 on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine

public protocol ChatRepository {
    func sendQuestion(sendingQuestionDTO: SendingQuestionDTO) -> AnyPublisher<ChatGPTAnswerVO, Error>
}
