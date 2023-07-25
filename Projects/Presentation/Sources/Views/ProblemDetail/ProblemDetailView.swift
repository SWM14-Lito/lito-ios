//
//  ProblemSolvingView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ProblemDetailView: View {
    
    @StateObject private var viewModel: ProblemDetailViewModel
    @FocusState private var focused: Bool
    
    public init(viewModel: ProblemDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            errorMessage
            if let problemDetailVO = viewModel.problemDetailVO {
                ScrollView {
                    question
                    if viewModel.solvingState == .notSolved {
                        answer(text: viewModel.answerWithoutKeyword ?? "")
                        textField
                        showAnswerButton
                        wrongMessage
                    } else {
                        answer(text: problemDetailVO.problemAnswer)
                        showChatGPTButton
                        listOfFAQ
                    }
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
            viewModel.getProblemDetail()
        }
        .onChange(of: viewModel.focused) {
            focused = $0
        }
    }
    
    // 문제 질문
    @ViewBuilder
    private var question: some View {
        if let problemDetailVO = viewModel.problemDetailVO {
            Text(problemDetailVO.problemQuestion)
                .padding(.bottom)
        }
    }
    
    // 문제 답변
    @ViewBuilder
    private func answer(text: String) -> some View {
        Text(text)
            .padding(.bottom)
    }
    
    // 답변 입력칸
    @ViewBuilder
    private var textField: some View {
        TextField("정답을 입력해주세요", text: $viewModel.input)
            .focused($focused)
            .multilineTextAlignment(.center)
            .padding(.bottom)
            .onSubmit {
                viewModel.handleInput()
            }
    }
    
    // 정답 보기 버튼
    @ViewBuilder
    private var showAnswerButton: some View {
        Button {
            viewModel.showAnswer()
        } label: {
            Text("정답 보기")
                .padding(.bottom)
        }
    }
    
    // 틀렸을 때 띄워주는 메시지
    @ViewBuilder
    private var wrongMessage: some View {
        if viewModel.isWrong {
            Text("틀렸습니다.")
                .foregroundColor(.red)
        }
    }
    
    // ChatGPT 버튼
    @ViewBuilder
    private var showChatGPTButton: some View {
        Button {
            viewModel.showChatGPT()
        } label: {
            Text("Chat GPT")
                .padding(.bottom)
        }
    }
    
    // FAQ 목록
    @ViewBuilder
    private var listOfFAQ: some View {
        if let problemDetailVO = viewModel.problemDetailVO,
           let faqs = problemDetailVO.faqs {
            VStack(alignment: .leading) {
                Text("FAQ")
                Divider()
                
                ForEach(faqs, id: \.self) { faq in
                    Text("Q) " + faq.faqQuestion)
                    Text("A) " + faq.faqAnswer)
                        .padding(.bottom)
                }
            }
        }
    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
}
