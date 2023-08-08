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
        let answer = "문맥 전환이란, CPU가 현재 실행중인 프로세스의 상태를 저장하고 다른 프로세스로 전환하는 과정을 말합니다. 이는 PCB에 현재 프로세스의 정보를 저장하고, 다른 프로세스의 정보를 읽어 레지스터에 로드하여 실행을 이어가는 것을 의미합니다."
        dialogue.append(
            DialogueUnitVO(text: answer, dialogueType: .fromChatGPT)
        )
    }
    
    func dismissSheet() {
        coordinator.dismissSheet()
    }
}
