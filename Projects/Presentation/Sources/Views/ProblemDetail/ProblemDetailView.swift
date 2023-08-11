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
                    VStack(alignment: .leading) {
                        questionLabel
                        question
                        switch viewModel.solvingState {
                        case .notSolved:
                            answer(text: viewModel.answerWithoutKeyword ?? "")
                            writingAnswer
                        case .waiting:
                            answer(text: viewModel.answerWithoutKeyword ?? "")
                            progressBarForAnswer
                        case .correct:
                            answer(text: viewModel.answerWithoutKeyword ?? "")
                            answerLabelButton
                        case .wrong:
                            answer(text: viewModel.answerWithoutKeyword ?? "")
                            answerLabelButton
                            showAnswerButton
                        case .showAnswer:
                            answer(text: problemDetailVO.problemAnswer)
                            showChatGPTButton
                            listOfFAQ
                        }

                        Spacer()
                    }
                }
            } else {
                ProgressView()
            }
        }
        .modifier(CustomNavigation(
            title: "문제풀이",
            back: viewModel.back,
            toolbarContent: SymbolButtonToolbar(
                placement: .navigationBarTrailing,
                symbolName: SymbolName.heartFill,
                action: viewModel.toggleFavorite)))
        .padding([.leading, .trailing], 20)
        .onAppear {
            viewModel.startSolvingProblem()
            viewModel.getProblemDetail()
        }
        
    }
    
    // 질문 라벨
    @ViewBuilder
    private var questionLabel: some View {
        Text("Question")
            .font(.Body2SemiBold)
            .foregroundColor(.white)
            .padding([.top, .bottom], 4)
            .padding([.leading, .trailing], 14)
            .background(.Bg_Point)
            .cornerRadius(14)
            .padding(.bottom, 8)
    }
    
    // 문제 질문
    @ViewBuilder
    private var question: some View {
        if let problemDetailVO = viewModel.problemDetailVO {
            Text(problemDetailVO.problemQuestion)
                .font(.Head3SemiBold)
                .foregroundColor(.Text_Default)
                .padding(.bottom, 12)
        }
    }
    
    // 문제 답변
    @ViewBuilder
    private func answer(text: String) -> some View {
        Text(text)
            .padding([.top, .bottom], 40)
            .padding([.leading, .trailing], 24)
            .background(.Bg_Light)
            .cornerRadius(20)
            .padding(.bottom, 45)
    }
    
    // 답변 입력칸
    @ViewBuilder
    private var writingAnswer: some View {
        TextField("", text: $viewModel.input)
            .placeholder(when: !focused && viewModel.input.isEmpty, alignment: .center, placeholder: {
                Text("정답을 입력해주세요")
                    .font(.Body1Regular)
                    .foregroundColor(.Text_Disabled)
            })
            .font(.Body1Regular)
            .foregroundColor(.Text_Default)
            .padding([.top, .bottom], 18)
            .padding([.leading, .trailing], 55)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(viewModel.input.isEmpty ? .Border_Default : .black, lineWidth: 1)
            )
            .padding(.bottom, 20)
            .multilineTextAlignment(.center)
            .focused($focused)
            .onSubmit {
                viewModel.submitAnswer()
            }
    }
    
    // 답변이 맞는지 서버에서 판별하는 동안 보져주는 로딩뷰
    @ViewBuilder
    private var progressBarForAnswer: some View {
        ProgressView()
            .foregroundColor(.Text_Default)
            .padding([.top, .bottom], 18)
            .padding([.leading, .trailing], 55)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.black, lineWidth: 1)
            )
            .padding(.bottom, 20)
    }
    
    // 정답 확인하고 다음 상태로 넘어갈 수 있는 버튼
    @ViewBuilder
    private var answerLabelButton: some View {
        Button {
            if viewModel.solvingState == .correct {
                viewModel.showAnswer()
            } else {
                viewModel.initInput()
            }
        } label: {
            Text(viewModel.solvingState == .correct ? "정답입니다! 👍" : "오답이네요 ☹️")
                .font(.Body1Regular)
                .foregroundColor(.white)
                .padding([.top, .bottom], 18)
                .padding([.leading, .trailing], 55)
                .frame(maxWidth: .infinity)
                .background(viewModel.solvingState == .correct ? .Button_Point : .Button_Red)
                .cornerRadius(10)
                .padding(.bottom, 20)
        }
        .buttonStyle(.plain)
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
