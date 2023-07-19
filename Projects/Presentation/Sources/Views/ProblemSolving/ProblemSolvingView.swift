//
//  ProblemSolvingView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ProblemSolvingView: View {
    
    @StateObject private var viewModel: ProblemSolvingViewModel
    @FocusState private var focused: Bool
    
    public init(viewModel: ProblemSolvingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            if let problemDetailVO = viewModel.problemDetailVO {
                VStack {
                    question
                    answer
                    textField
                    showAnswerButton
                    wrongMessage
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.toggleFavorite()
                        } label: {
                            Image(systemName: problemDetailVO.favorite.symbolName)
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .padding([.leading, .trailing])
        .onAppear {
            viewModel.getProblemInfo()
        }
        .onChange(of: viewModel.focused) {
            focused = $0
        }
    }
    
    @ViewBuilder
    private var question: some View {
        if let problemDetailVO = viewModel.problemDetailVO {
            Text(problemDetailVO.question)
                .padding(.bottom)
        }
    }
    
    @ViewBuilder
    private var answer: some View {
        if let answerWithoutKeyword = viewModel.answerWithoutKeyword {
            Text(answerWithoutKeyword)
                .padding(.bottom)
        }
    }
    
    @ViewBuilder
    private var textField: some View {
        TextField("", text: $viewModel.input)
            .focused($focused)
            .multilineTextAlignment(.center)
            .padding(.bottom)
            .onSubmit {
                viewModel.handleInput()
            }
    }
    
    @ViewBuilder
    private var showAnswerButton: some View {
        Button {
            viewModel.showAnswer()
        } label: {
            Text("정답 보기")
                .padding(.bottom)
        }
    }
    
    @ViewBuilder
    private var wrongMessage: some View {
        if !viewModel.isCorrect {
            Text("틀렸습니다.")
                .foregroundColor(.red)
        }
    }
}
