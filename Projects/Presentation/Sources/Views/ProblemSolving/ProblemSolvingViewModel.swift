//
//  ProblemSolvingViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import SwiftUI

public class ProblemSolvingViewModel: BaseViewModel {
    private let useCase: ProblemSolvingUseCase
    private var problemId: Int?
    @Published var problemDetailVO: ProblemDetailVO?
    @Published var answerWithoutKeyword: String?
    @Published var input: String = ""
    @Published var focused: Bool = false
    @Published var isWrong: Bool = false
    @Published var solvingState: SolvingState = .notSolved
    
    enum SolvingState {
        case solved
        case notSolved
    }
    
    public init(useCase: ProblemSolvingUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    // 이전 화면에서 id 파라미터를 넘겨받기 위해 사용
    public func setProblemId(id: Int) {
        self.problemId = id
    }
    
    // API 통신해서 문제 세부 정보 가져오기
    func getProblemInfo() {
        useCase.getProblemInfo()
            .sinkToResult { result in
                switch result {
                case .success(let problemDetailVO):
                    self.problemDetailVO = problemDetailVO
                    self.hideKeyword()
                    self.showKeyboard()
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
    
    // 정답이 나오는 상태로 화면을 변경
    func showAnswer() {
        isWrong = false
        solvingState = .solved
        useCase.showAnswer()
    }
    
    // 문제 찜하기 선택 및 해제
    func toggleFavorite() {
        problemDetailVO?.favorite.toggle()
        useCase.toggleFavorite()
    }
    
    // 사용자가 키보드 엔터 눌렀을 때 정답 여부에 따라 다음 상태로 이동하기
    func handleInput() {
        if input == problemDetailVO?.keyword {
            showAnswer()
            useCase.correct()
        } else {
            isWrong = true
            useCase.wrong()
        }
    }
    
    // ChatGPT 화면 모달로 보여주기
    func showChatGPT() {
        
    }
    
    // 키보드 보여주기
    private func showKeyboard() {
        focused = true
    }
    
    // 문제에 대한 답변에서 키워드 부분은 숨기기
    private func hideKeyword() {
        guard let problemDetailVO = problemDetailVO else { return }
        let wordLength = problemDetailVO.keyword.count
        answerWithoutKeyword = problemDetailVO.answer.replacingOccurrences(of: problemDetailVO.keyword, with: String(repeating: " _ ", count: wordLength))
    }
}
