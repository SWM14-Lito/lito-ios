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
    
    private var getProblemDetailResponse: AnyPublisher<ProblemDetailVO, Error> = Just(ProblemDetailVO(
        problemId: 0,
        problemQuestion: "문맥 전환이 무엇인가?",
        problemAnswer: "CPU가 이전 상태의 프로세스를 PCB에 보관하고, 또 다른 프로세스를 PCB에서 읽어 레지스터에 적재하는 과정",
        problemKeyword: "PCB",
        problemStatus: .solved,
        favorite: .favorite,
        faqs: []
    ))
    .setFailureType(to: Error.self)
    .eraseToAnyPublisher()
    private var toggleProblemFavoriteResponse: AnyPublisher<Void, Error> = Just(Void())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    private var startSolvingProblemResponse: AnyPublisher<Void, Error> = Just(Void())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    private var submitAnswerResponse: AnyPublisher<ProblemSolvedVO, Error> = Just(ProblemSolvedVO(solved: true))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    
    public init() { }
    
    // 테스트시 특정 값을 반환하도록 하고 싶다면 함수 호출해서 세팅해주기
    func setGetProblemDetailResponse(_ response: AnyPublisher<ProblemDetailVO, Error>) {
        self.getProblemDetailResponse = response
    }
    func setToggleProblemFavoriteResponse(_ response: AnyPublisher<Void, Error>) {
        self.toggleProblemFavoriteResponse = response
    }
    func setStartSolvingProblemResponse(_ response: AnyPublisher<Void, Error>) {
        self.startSolvingProblemResponse = response
    }
    func setSubmitAnswer(_ response: AnyPublisher<ProblemSolvedVO, Error>) {
        self.submitAnswerResponse = response
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        getProblemDetailResponse
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        toggleProblemFavoriteResponse
    }
    
    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        startSolvingProblemResponse
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error> {
        submitAnswerResponse
    }
}
