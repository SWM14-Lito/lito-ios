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
    private let problemId: Int
    
    public init(question: String, answer: String, problemId: Int, useCase: ChattingUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.question = question
        self.answer = answer
        self.problemId = problemId
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }
    
    // 질문 보내기
    func sendQuestion() {
        lastNetworkAction = sendQuestion
        dialogue += [
            DialogueUnitVO(text: input, dialogueType: .fromUser),
            DialogueUnitVO(dialogueType: .fromChatGPTWaiting)
        ]
        useCase.sendQuestion(sendingQuestionDTO: SendingQuestionDTO(message: input, problemId: problemId))
            .sinkToResultWithErrorHandler({ chatGPTAnswerVO in
                self.dialogue[self.dialogue.count-1] = DialogueUnitVO(text: chatGPTAnswerVO.messages[0].message, dialogueType: .fromChatGPT)
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
        input = ""
    }
    
    // 모달 내리기
    func dismissSheet() {
        coordinator.dismissSheet()
    }
}
