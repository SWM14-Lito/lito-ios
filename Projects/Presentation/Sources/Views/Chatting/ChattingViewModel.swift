//
//  ChatGPTViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/28.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import SwiftUI

public class ChattingViewModel: BaseViewModel {
    
    @Published var input: String = ""
    @Published var dialogue = [DialogueUnitVO]()
    private let useCase: ChattingUseCase
    let question: String
    let answer: String
    
    public init(question: String, answer: String, useCase: ChattingUseCase, coordinator: CoordinatorProtocol) {
        self.question = question
        self.answer = answer
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    // 질문 보내기
    func sendQuestion() {
        dialogue += [
            DialogueUnitVO(text: input, dialogueType: .fromUser),
            DialogueUnitVO(dialogueType: .fromChatGPTWaiting)
        ]
        input = ""
        useCase.sendQuestion(sendingQuestionDTO: SendingQuestionDTO(message: input))
            .sinkToResult { result in
                switch result {
                case .success(let chatGPTAnswerVO):
                    self.dialogue[self.dialogue.count-1] = DialogueUnitVO(text: chatGPTAnswerVO.messages[0].message, dialogueType: .fromChatGPT)
                case .failure(let error):
                    self.dialogue[self.dialogue.count-1] = DialogueUnitVO(dialogueType: .fromChatGPTFail)
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
    
    // 모달 내리기
    func dismissSheet() {
        coordinator.dismissSheet()
    }
}
