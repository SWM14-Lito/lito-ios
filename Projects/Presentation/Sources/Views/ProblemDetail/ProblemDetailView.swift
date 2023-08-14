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
            ScrollView {
                VStack(alignment: .leading) {
                    questionLabel
                    if viewModel.problemDetailVO != nil {
                        question
                        switch viewModel.solvingState {
                        case .notSolved:
                            answerBox
                            writingAnswer
                        case .waiting:
                            answerBox
                            progressBarForAnswer
                        case .correct:
                            answerBox
                            answerLabelButton
                        case .wrong:
                            answerBox
                            answerLabelButton
                        case .wronWithInput:
                            answerBox
                            writingAnswer
                            showAnswerButton
                        case .showAnswer:
                            answerBoxWithChatGPTButton
                            listOfFaq
                        }
                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .modifier(CustomNavigation(
            title: "문제풀이",
            back: viewModel.back,
            toolbarContent: SymbolButtonToolbar(
                placement: .navigationBarTrailing,
                symbolName: SymbolName.heartFill,
                color: viewModel.problemDetailVO?.favorite == .favorite ? .Heart_Clicked_Outer : .Icon_Default,
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
            .padding(.top, 10)
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
    private var answerBox: some View {
        Text(viewModel.answerWithoutKeyword ?? "")
            .font(.Body2Regular)
            .foregroundColor(.Text_Default)
            .padding([.top, .bottom], 40)
            .padding([.leading, .trailing], 24)
            .background(.Bg_Light)
            .cornerRadius(20)
            .padding(.bottom, 45)
    }
    
    // ChatGPT 버튼이 있는 문제 답변
    @ViewBuilder
    private var answerBoxWithChatGPTButton: some View {
        VStack(spacing: 30) {
            Text(viewModel.problemDetailVO?.problemAnswer ?? "")
                .font(.Body2Regular)
                .foregroundColor(.Text_Default)
                .padding([.leading, .trailing], 24)
            showChatGPTButton
                .padding([.leading, .trailing], 30)
        }
        .padding(.top, 40)
        .padding(.bottom, 23)
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
            HStack(spacing: 10) {
                Image(.chatgpt)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                Text("Chat GPT 질문하기")
                    .font(.Body2Regular)
                    .foregroundColor(.white)
            }
            .padding([.top, .bottom], 13)
            .padding([.leading, .trailing], 55)
            .background(.Button_Dark_Green)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
    
    // FAQ 목록
    @ViewBuilder
    private var listOfFaq: some View {
        if let problemDetailVO = viewModel.problemDetailVO,
           let faqs = problemDetailVO.faqs {
            VStack(alignment: .leading, spacing: 8) {
                Text("FAQ")
                    .font(.Head3SemiBold)
                    .foregroundColor(.Text_Default)
                    .padding(.bottom, 2)
                
                ForEach(faqs.indices, id: \.self) { idx in
                    faqCell(idx: idx, question: faqs[idx].faqQuestion, answer: faqs[idx].faqAnswer)
                }
            }
        }
    }
    
    // FAQ 셀
    @ViewBuilder
    private func faqCell(idx: Int, question: String, answer: String) -> some View {
        if let faqIsOpened = viewModel.faqIsOpened {
            if faqIsOpened[idx] {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(alignment: .top, spacing: 10) {
                        Text(question)
                            .font(.Body2Medium)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: SymbolName.chevronUp)
                            .font(.system(size: 15))
                            .foregroundColor(.Text_Info)
                    }
                    .padding(.trailing, 15)
                    Text(answer)
                        .font(.Body3Regular)
                        .foregroundColor(.Text_Serve)
                        .padding(.trailing, 20)
                }
                .padding(.leading, 20)
                .padding([.top, .bottom], 18)
                .background(.Bg_Soft_Blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.Border_Strong, lineWidth: 1)
                )
                .onTapGesture {
                    viewModel.toggleFaqOpenStatus(idx: idx)
                }
            } else {
                HStack(spacing: 10) {
                    Text(question)
                        .font(.Body2Medium)
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: SymbolName.chevronDown)
                        .font(.system(size: 15))
                        .foregroundColor(.Text_Info)
                }
                .padding(.leading, 20)
                .padding(.trailing, 15)
                .padding([.top, .bottom], 18)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.Border_Default, lineWidth: 1)
                )
                .onTapGesture {
                    viewModel.toggleFaqOpenStatus(idx: idx)
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
