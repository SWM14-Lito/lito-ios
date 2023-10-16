//
//  ProblemSolvingViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import SwiftUI

public class ProblemDetailViewModel: BaseViewModel {
    private let useCase: ProblemDetailUseCase
    private let keywordBoxMaxLength = 9
    let problemId: Int
    let stateChangingTime = 2.0
    var showSubmittedInput: Bool {
        return solvingState == .correctKeyword || solvingState == .wrongKeyword || solvingState == .showAnswer
    }
    var IsWrongBefore: Bool {
        return solvingState == .wrongKeyword || (solvingState == .initial && !isFirstTry)
    }
    @Published var input: String = ""
    @Published private(set) var problemDetailVO: ProblemDetailVO?
    @Published private(set) var solvingState: SolvingState = .initial
    @Published private(set) var faqIsOpened: [Bool]?
    @Published private(set) var inputErrorMessage: String = ""
    @Published private(set) var answerSplited = [String]()
    @Published private(set) var keywordRange = [(Int, Int)]()
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isFirstTry: Bool = true
    @Published private(set) var isWrongInput: Bool = false
    
    enum SolvingState {
        case initial
        case correctKeyword
        case wrongKeyword
        case showAnswer
    }
    
    public init(problemId: Int, useCase: ProblemDetailUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        self.problemId = problemId
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }
    
    // 화면 나오면 문제 받아오고 풀이 시작 상태 알려주기
    public func onScreenAppeared() {
        startSolvingProblem()
        getProblemDetail()
    }
    
    // 정답보기 버튼 눌리면 정답 보여주기
    public func onShowAnswerButtonClicked() {
        showAnswer()
    }
    
    // 문제 찜하기 선택 및 해제
    public func onFavoriteButtonClicked() {
        lastNetworkAction = onFavoriteButtonClicked
        useCase.toggleProblemFavorite(id: problemId)
            .sinkToResultWithErrorHandler({ _ in
                    self.problemDetailVO?.favorite.toggle()
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    // ChatGPT 화면 모달로 보여주기
    public func onChatGPTButtonClicked() {
        coordinator.present(sheet: .chattingScene(question: problemDetailVO?.problemQuestion ?? "Unknown", answer: problemDetailVO?.problemAnswer ?? "Unknown", problemId: problemDetailVO?.problemId ?? 1))
    }
    
    // 서버에 유저가 적은 키워드 제출해서 정답인지 확인하기
    public func onAnswerSubmitted() {
        lastNetworkAction = onAnswerSubmitted
        if checkInput() {
           isWrongInput = false
           isLoading = true
            useCase.submitAnswer(id: problemId, keyword: input)
                .sinkToResultWithErrorHandler({ problemSolvedVO in
                    if problemSolvedVO.solved == true {
                        self.solvingState = .correctKeyword
                    } else {
                        self.solvingState = .wrongKeyword
                        self.isFirstTry = false
                    }
                    self.changeStateFromSolvingResult()
                    self.isLoading = false
                }, errorHandler: errorHandler)
                .store(in: cancelBag)
        } else {
            isWrongInput = true
        }
    }
    
    // faq 열림, 닫힘 상태 변경하기
    public func onFaqClicked(idx: Int) {
        faqIsOpened?[idx].toggle()
    }
    
    // 문제 풀이 결과 보고 다음 상태로 바꾸기
    private func changeStateFromSolvingResult() {
        DispatchQueue.main.asyncAfter(deadline: .now()+stateChangingTime) {
            if self.solvingState == .correctKeyword {
                self.showAnswer()
            } else if self.solvingState == .wrongKeyword {
                self.initInput()
            }
        }
    }
    
    // 다시 입력받도록 초기화 상태로 변경
    private func initInput() {
        solvingState = .initial
        input = ""
    }
    
    // API 통신해서 문제 세부 정보 가져오기
    private func getProblemDetail() {
        lastNetworkAction = getProblemDetail
        useCase.getProblemDetail(id: problemId)
            .sinkToResultWithErrorHandler({ problemDetailVO in
                self.problemDetailVO = problemDetailVO
                self.faqIsOpened = Array(repeating: false, count: problemDetailVO.faqs?.count ?? 0)
                self.splitSentence()
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    // 문제 풀기 시작한다는거 서버에 알려주기
    private func startSolvingProblem() {
        lastNetworkAction = startSolvingProblem
        useCase.startSolvingProblem(id: problemId)
            .sinkToResultWithErrorHandler({ _ in }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    // 정답이 나오는 상태로 변경
    private func showAnswer() {
        lastNetworkAction = showAnswer
        useCase.submitAnswer(id: problemId, keyword: problemDetailVO?.problemKeyword ?? "")
            .sinkToResultWithErrorHandler({ _ in
                self.input = self.problemDetailVO?.problemKeyword ?? ""
                self.solvingState = .showAnswer
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    // 입력값이 틀렸는지 확인해주기
    private func checkInput() -> Bool {
        guard let keyword = problemDetailVO?.problemKeyword else { return false }
        if input.count != keyword.count {
            return false
        } else {
            return true
        }
    }
    
    // 문제에 대한 답변에서 단어별 (키워드 포함) 로 쪼개기
    private func splitSentence() {
        guard let problemDetailVO = problemDetailVO else { return }
        let keyword = problemDetailVO.problemKeyword
        
        var keywordDistinguished = problemDetailVO.problemAnswer.replacingOccurrences(of: keyword, with: " " + keyword + " ")
        
        answerSplited = keywordDistinguished.split(separator: " ").map { String($0) }
        for word in answerSplited {
            if word == keyword {
                keywordRange.append((0, keyword.count))
            } else {
                keywordRange.append((-1, -1))
            }
        }
        
        if keyword.count > keywordBoxMaxLength {
            keywordDistinguished = keywordDistinguished.replacingOccurrences(of: keyword, with: keyword[0..<keywordBoxMaxLength] + " " + keyword[keywordBoxMaxLength..<keyword.count] )
            
            for idx in (0..<answerSplited.count).reversed() {
                if keywordRange[idx].0 != -1 {
                    keywordRange[idx] = (keywordBoxMaxLength, keyword.count)
                    keywordRange.insert((0, keywordBoxMaxLength), at: idx)
                }
            }
            
            answerSplited = keywordDistinguished.split(separator: " ").map { String($0) }
            
            print(keywordRange)
            print(answerSplited)
        }
    }
}
