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
    
    func sendQuestion() {
        dialogue.append(
            DialogueUnitVO(text: input, dialogueType: .fromUser)
        )
        input = ""
        // TODO: 서버로 질문 보내기
    }
    
    func getAnswer() {
        // TODO: 서버에서 대답 받아오기
        let answer = "--- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 --- ChatGPT 대답 ---"
        dialogue.append(
            DialogueUnitVO(text: answer, dialogueType: .fromChatGPT)
        )
    }
    
    func dismissSheet() {
        coordinator.dismissSheet()
    }
}
