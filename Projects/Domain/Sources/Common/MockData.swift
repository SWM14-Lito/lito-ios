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
        favorite: .favorite
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
