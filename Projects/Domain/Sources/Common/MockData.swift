//
//  MockDataMaker.swift
//  Domain
//
//  Created by 김동락 on 2023/07/20.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public final class MockData {
    static let problemDetailVO = ProblemDetailVO(
        question: "문맥 전환 (Context Switching)이 무엇인가?",
        answer: "CPU가 이전 상태의 프로세스를 PCB에 보관하고, 또 다른 프로세스를 PCB에서 읽어 레지스터에 적재하는 과정.",
        keyword: "PCB",
        favorite: .favorite,
        faqs: [
            ProblemFAQVO(
                question: "CPU란 무엇인가요?",
                answer: "CPU란 중앙 처리 장치 또는 CPU는 컴퓨터 시스템을 통제하고 프로그램의 연산을 실행 · 처리하는 가장 핵심적인 컴퓨터의 제어 장치, 혹은 그 기능을 내장한 칩입니다."
            ),
            ProblemFAQVO(
                question: "레지스터란 무엇인가요?",
                answer: "프로세서 레지스터 또는 단순히 레지스터는 컴퓨터의 프로세서 내에서 자료를 보관하는 아주 빠른 기억 장소입니다. 일반적으로 현재 계산을 수행중인 값을 저장하는 데 사용됩니다."
            )
        ]
    )
    
    static let learningHomeUserInfoVO = LearningHomeUserInfoVO(
        userId: 1,
        profileImgUrl: nil,
        nickname: "번개다람쥐"
    )
    
    static let problemCellVO = ProblemCellVO(
        problemId: 1,
        solved: .solved,
        question: "문맥 전환 (Context Switching)이 무엇인가?",
        subject: "운영체제",
        favorite: .favorite
    )
    
    static let learningHomeVO = LearningHomeVO(
        userInfo: learningHomeUserInfoVO,
        recommendedProblem: problemCellVO
    )
    
    static func getMockData<T>(timeAfter: Float = 0.5, data: T) -> AnyPublisher<T, Error> {
        Future<T, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }
}
