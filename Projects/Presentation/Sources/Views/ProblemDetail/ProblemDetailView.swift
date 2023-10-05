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
        ZStack {
            if viewModel.problemDetailVO != nil {
                ScrollView {
                    VStack(alignment: .leading) {
                        questionLabel
                        question
                        switch viewModel.solvingState {
                        case .initial:
                            if viewModel.isLoading {
                                answerBox
                                progressBarForAnswer
                            } else {
                                ZStack(alignment: .bottom) {
                                    answerBox
                                        .onAppear {
                                            focused = true
                                        }
                                    if !viewModel.isFirstTry {
                                        showAnswerButton
                                    }
                                }
                                writingAnswer
                            }
                            if !focused && !viewModel.isLoading && viewModel.isWrongInput {
                                inputError
                            }
                        case .wrongKeyword, .correctKeyword:
                            answerBox
                            answerLabelButton
                        case .showAnswer:
                            answerBoxWithChatGPTButton
                            listOfFaq
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding([.leading, .trailing], 20)
            } else {
                LoadingView()
            }
        }
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
        .modifier(CustomNavigation(
            title: StringLiteral.problemDetailViewNavigationTitle,
            back: viewModel.back,
            toolbarContent: SymbolButtonToolbar(
                placement: .navigationBarTrailing,
                symbolName: SymbolName.heartFill,
                color: viewModel.problemDetailVO?.favorite == .favorite ? .Heart_Clicked_Outer : .Icon_Default,
                action: viewModel.onFavoriteButtonClicked),
            disabled: viewModel.presentErrorAlert))
        .onAppear {
            viewModel.onScreenAppeared()
        }
        
    }
    
    // 질문 라벨
    @ViewBuilder
    private var questionLabel: some View {
        Text(StringLiteral.questionLabelTitle)
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
        WHStack {
            makeAnswerBoxComponents()
        }
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
            WHStack {
                makeAnswerBoxComponents()
            }
            .padding([.leading, .trailing], 24)
            showChatGPTButton
                .padding([.leading, .trailing], 30)
        }
        .padding(.top, 40)
        .padding(.bottom, 23)
        .frame(maxWidth: .infinity)
        .background(.Bg_Light)
        .cornerRadius(20)
        .padding(.bottom, 45)
    }
    
    // 답변 입력칸
    @ViewBuilder
    private var writingAnswer: some View {
        ScrollViewReader { proxy in
            TextField("", text: $viewModel.input)
                .placeholder(when: !focused && viewModel.input.isEmpty, alignment: .center, placeholder: {
                    Text(StringLiteral.answerFieldPlaceHolder)
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
                    viewModel.onAnswerSubmitted()
                }
                .id("writingAnswer")
                .onChange(of: focused) { _ in
                    if focused {
                        proxy.scrollTo("writingAnswer")
                    }
                }
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
        Text(viewModel.solvingState == .correctKeyword ? StringLiteral.answerCorrectMessage : StringLiteral.answerWrongMessage)
            .font(.Body1Regular)
            .foregroundColor(.white)
            .padding([.top, .bottom], 18)
            .padding([.leading, .trailing], 55)
            .frame(maxWidth: .infinity)
            .background(viewModel.solvingState == .correctKeyword ? .Button_Point : .Button_Red)
            .cornerRadius(10)
            .padding(.bottom, 20)
    }
    
    // 정답 보기 버튼
    @ViewBuilder
    private var showAnswerButton: some View {
        Button {
            viewModel.onShowAnswerButtonClicked()
        } label: {
            Text(StringLiteral.showAnswerLabelTitle)
                .font(.Info2Regular)
                .foregroundColor(.Text_Default)
                .padding([.leading, .trailing], 10)
                .padding([.top, .bottom], 5)
                .background(.white)
                .cornerRadius(11)
                .opacity(0.95)
                .shadow(color: .Shadow_Default, radius: 4, x: 0, y: 2)
                .padding(.bottom, 33)
        }
    }
    
    // ChatGPT 버튼
    @ViewBuilder
    private var showChatGPTButton: some View {
        Button {
            viewModel.onChatGPTButtonClicked()
        } label: {
            HStack(spacing: 10) {
                Image(.chatgpt)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                Text(StringLiteral.chatGPTAskButtonTitle)
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
                Text(StringLiteral.faq)
                    .font(.Head3SemiBold)
                    .foregroundColor(.Text_Default)
                    .padding(.bottom, 2)
                
                ForEach(faqs.indices, id: \.self) { idx in
                    faqCell(idx: idx, question: faqs[idx].faqQuestion, answer: faqs[idx].faqAnswer)
                }
                
                if faqs.isEmpty {
                    NoContentView(message: StringLiteral.noFaqMessage, withSymbol: false, background: .white)
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
                            .fixedSize(horizontal: false, vertical: true)
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
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.leading, 20)
                .padding([.top, .bottom], 18)
                .background(.Bg_Soft_Blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.Border_Strong, lineWidth: 1)
                )
                .onTapGesture {
                    viewModel.onFaqClicked(idx: idx)
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
                    viewModel.onFaqClicked(idx: idx)
                }
            }
        }
    }
    
    // 키워드 컴포넌트
    @ViewBuilder
    private var keywordBox: some View {
        if let keyword = viewModel.problemDetailVO?.problemKeyword {
            HStack(spacing: 3) {
                ForEach(0..<keyword.count, id: \.self) { idx in
                    ZStack {
                        RoundedRectangle(cornerRadius: 3)
                            .strokeBorder(viewModel.IsWrongBefore ? .Border_Serve_Red  : .Border_Serve, lineWidth: 1)
                            .frame(width: 26, height: 26)
                            .background(.white)
                        if viewModel.showSubmittedInput {
                            Text(viewModel.input[idx])
                                .font(.Body1SemiBold)
                                .foregroundColor(viewModel.IsWrongBefore ? .Text_Point_Red : .Text_Point)
                        }
                    }
                }
            }
            .padding(6)
            .background(viewModel.IsWrongBefore ? .Bg_Soft_Red : .Bg_Dark_Soft_Blue)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(viewModel.IsWrongBefore ? .Border_Strong_Red : .Border_Strong, lineWidth: focused ? 1 : 0)
            )
        }
    }
    
    // 입력값에 대한 오류 메시지
    @ViewBuilder
    private var inputError: some View {
        Text( String(viewModel.problemDetailVO?.problemKeyword.count ?? 0) + StringLiteral.answerLengthErrorMessage)
            .foregroundColor(.Text_Point_Red)
            .font(.InfoRegular)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // 일반 단어와 키워드 뷰컴포넌트를 구분해서 리스트에 담아주기
    private func makeAnswerBoxComponents() -> [AnyView] {
        var components = [AnyView]()
        if let answerSplited = viewModel.answerSplited {
            for word in answerSplited {
                if word == viewModel.problemDetailVO?.problemKeyword {
                    components.append(
                        AnyView(
                            keywordBox
                        )
                    )
                } else {
                    components.append(
                        AnyView(
                            Text(word)
                                .font(.Body2Regular)
                                .foregroundColor(.Text_Default)
                                .fixedSize(horizontal: true, vertical: false)
                        )
                    )
                }
            }
        }
        return components
    }
}
