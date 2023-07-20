//
//  ProblemSolvingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol ProblemSolvingUseCase {
    func getProblemInfo() -> AnyPublisher<ProblemDetailVO, Error>
    func showAnswer()
    func toggleFavorite()
    func correct()
    func wrong()
}

public final class DefaultProblemSolvingUseCase: ProblemSolvingUseCase {
    
    private let repository: ProblemSolvingRepository
    
    public init(repository: ProblemSolvingRepository) {
        self.repository = repository
    }
    
    public func getProblemInfo() -> AnyPublisher<ProblemDetailVO, Error> {
        // 테스트용
        Future<ProblemDetailVO, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vo = ProblemDetailVO(
                    question: "문맥 전환 (Context Switching)이 무엇인가?",
                    answer: "CPU가 이전 상태의 프로세스를 PCB에 보관하고, 또 다른 프로세스를 PCB에서 읽어 레지스터에 적재하는 과정.",
                    keyword: "PCB",
                    favorite: .favorite
                )
                promise(.success(vo))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func showAnswer() {
        
    }
    
    public func toggleFavorite() {
        
    }
    
    public func handleInput() {
        
    }
    
    public func correct() {
        
    }
    
    public func wrong() {
        
    }
}
