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
    
    private var getProblemDetailResponse: ((Int) -> AnyPublisher<ProblemDetailVO, Error>)?
    private var toggleProblemFavoriteResponse: ((Int) -> AnyPublisher<Void, Error>)?
    private var startSolvingProblemResponse: ((Int) -> AnyPublisher<Void, Error>)?
    private var submitAnswerResponse: ((Int, String) -> AnyPublisher<ProblemSolvedVO, Error>)?
    
    public init() { }
    
    // 테스트시 특정 값을 반환하도록 하고 싶다면 함수 호출해서 세팅해주기
    public func setGetProblemDetailResponse(response: @escaping ((Int) -> AnyPublisher<ProblemDetailVO, Error>)) {
        self.getProblemDetailResponse = response
    }
    
    public func setToggleProblemFavoriteResponse(response: @escaping ((Int) -> AnyPublisher<Void, Error>)) {
        self.toggleProblemFavoriteResponse = response
    }
    
    public func setStartSolvingProblemResponse(response: @escaping ((Int) -> AnyPublisher<Void, Error>)) {
        self.startSolvingProblemResponse = response
    }
    
    public func setSubmitAnswerResponse(response: @escaping ((Int, String) -> AnyPublisher<ProblemSolvedVO, Error>)) {
        self.submitAnswerResponse = response
    }
    
    public func getProblemDetail(id: Int) -> AnyPublisher<ProblemDetailVO, Error> {
        if let getProblemDetailResponse = getProblemDetailResponse {
            // 따로 설정해줬으면 해당 값 반환
            return getProblemDetailResponse(id)
        } else {
            // 디폴트로 반환
            return Just(ProblemDetailVO(
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
        }
    }
    
    public func toggleProblemFavorite(id: Int) -> AnyPublisher<Void, Error> {
        if let toggleProblemFavoriteResponse = toggleProblemFavoriteResponse {
            return toggleProblemFavoriteResponse(id)
        } else {
            return Just(Void())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    public func startSolvingProblem(id: Int) -> AnyPublisher<Void, Error> {
        if let startSolvingProblemResponse = startSolvingProblemResponse {
            return startSolvingProblemResponse(id)
        } else {
            return Just(Void())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    public func submitAnswer(id: Int, keyword: String) -> AnyPublisher<ProblemSolvedVO, Error> {
        if let submitAnswerResponse = submitAnswerResponse {
            return submitAnswerResponse(id, keyword)
        } else {
            return Just(keyword == "PCB" ? ProblemSolvedVO(solved: true) : ProblemSolvedVO(solved: false))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
