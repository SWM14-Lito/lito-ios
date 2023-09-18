//
//  ProblemSolvingUseCase.swift
//  Domain
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Combine
import Foundation

public protocol ProblemDetailUseCase {
    func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error>
    func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error>
    func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error>
    func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error>
}

public final class DefaultProblemDetailUseCase: ProblemDetailUseCase {
    
    private let repository: ProblemRepository
    
    public init(repository: ProblemRepository) {
        self.repository = repository
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        repository.getProblemDetail(id: id)
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        repository.toggleProblemFavorite(id: id)
    }
    
    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        repository.startSolvingProblem(id: id)
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error> {
        repository.submitAnswer(id: id, keyword: keyword)
    }
}

public final class MockProblemDetailUseCase: ProblemDetailUseCase {
    
    public init() { }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        Future<ProblemDetailVO, Error> { promise in
            promise(.success(ProblemDetailVO(
                problemId: 0,
                problemQuestion: "문맥 전환이 무엇인가?",
                problemAnswer: "CPU가 이전 상태의 프로세스를 PCB에 보관하고, 또 다른 프로세스를 PCB에서 읽어 레지스터에 적재하는 과정",
                problemKeyword: "PCB",
                problemStatus: .solved,
                favorite: .favorite,
                faqs: []
            )))
        }
        .eraseToAnyPublisher()
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(Void()))
        }
        .eraseToAnyPublisher()
    }
    
    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(Void()))
        }
        .eraseToAnyPublisher()
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error> {
        Future<ProblemSolvedVO, Error> { promise in
            if keyword == "PCB" {
                promise(.success(ProblemSolvedVO(solved: true)))
            } else {
                promise(.success(ProblemSolvedVO(solved: false)))
            }
        }
        .eraseToAnyPublisher()
    }
}
