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
    @Published var isCorrect: Bool = true
    
    public init(useCase: ProblemSolvingUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    public func setProblemId(id: Int) {
        self.problemId = id
    }
    
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
    
    func showAnswer() {
        isCorrect = true
        print("정답 보여주기")
    }
    
    func toggleFavorite() {
        problemDetailVO?.favorite.toggle()
    }
    
    func handleInput() {
        if input == problemDetailVO?.keyword {
            showAnswer()
        } else {
            isCorrect = false
        }
    }
    
    private func showKeyboard() {
        focused = true
    }
    
    private func hideKeyword() {
        guard let problemDetailVO = problemDetailVO else { return }
        let wordLength = problemDetailVO.keyword.count
        answerWithoutKeyword = problemDetailVO.answer.replacingOccurrences(of: problemDetailVO.keyword, with: String(repeating: " _ ", count: wordLength))
    }
}
