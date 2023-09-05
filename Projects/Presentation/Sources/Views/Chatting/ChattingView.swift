//
//  ChatGPTView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/28.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

public struct ChattingView: View {
    
    @StateObject private var viewModel: ChattingViewModel
    @FocusState private var focused: Bool
    
    public init(viewModel: ChattingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            closeButton
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    explanation
                    problemDetail
                    dialogueList
                }
            }
            .padding(.bottom, 10)
            Divider()
                .background(.Divider_Default)
            questionTextfield
        }
        .onAppear {
            focused = true
        }
        .padding([.leading, .trailing], 20)
        .interactiveDismissDisabled()
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
    }
    
    // 모달 닫는 버튼
    @ViewBuilder
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                viewModel.dismissSheet()
            } label: {
                Image(systemName: SymbolName.xmarkCircleFill)
                    .font(.system(size: 34))
                    .foregroundStyle(.black, .Bg_Dark_Deep)
            }
            .padding(.top, 20)
        }
    }
    
    // 설명
    @ViewBuilder
    private var explanation: some View {
        Text("해당 문제에 대해 궁금한 점을 질문해주세요.")
            .foregroundColor(.Text_Serve)
            .font(.Body2Regular)
            .padding(.top, 4)
    }
    
    // 문제 질문과 답
    @ViewBuilder
    private var problemDetail: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 5) {
                Circle()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.Bg_Point)
                    .overlay {
                        Text("Q")
                            .foregroundColor(.white)
                            .font(.Body3SemiBold)
                    }
                Text(viewModel.question)
                    .foregroundColor(.Text_Default)
                    .font(.Body2SemiBold)
            }
            HStack(alignment: .top, spacing: 5) {
                Circle()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.Bg_Yellow)
                    .overlay {
                        Text("A")
                            .foregroundColor(.white)
                            .font(.Body3SemiBold)
                    }
                Text(viewModel.answer)
                    .foregroundColor(.Text_Default)
                    .font(.Body2Regular)
            }
        }
        .padding([.top, .bottom], 18)
        .padding([.leading, .trailing], 15)
        .background(.Bg_Soft_Blue)
        .cornerRadius(16)
        .padding(.top, 12)
    }
    
    // 대화 보여주기
    @ViewBuilder
    private var dialogueList: some View {
        ScrollViewReader { value in
            VStack(spacing: 24) {
                ForEach(viewModel.dialogue.indices, id: \.self) { index in
                    let dialogueUnit = viewModel.dialogue[index]
                    dialogueCell(cellType: dialogueUnit.dialogueType, text: dialogueUnit.text)
                        .id(index)
                }
                .onChange(of: viewModel.dialogue) { _ in
                    value.scrollTo(viewModel.dialogue.count - 1)
                }
            }
        }
        .padding(.top, 40)
    }
    
    // 질문 입력하기
    @ViewBuilder
    private var questionTextfield: some View {
        HStack(spacing: 0) {
            TextField("ChatGPT에게 궁금한 점을 질문해보세요!", text: $viewModel.input)
                .font(.Body2Regular)
                .padding([.top, .bottom], 14)
                .padding(.leading, 18)
                .focused($focused)
                .onSubmit {
                    viewModel.sendQuestion()
                }
            Spacer()
            Button {
                viewModel.sendQuestion()
            } label: {
                Image(systemName: SymbolName.paperplaneFill)
                    .font(.system(size: 18))
                    .foregroundColor(.Button_Point)
            }
            .padding(.trailing, 20)
        }
        .frame(height: 44)
        .background(.Bg_Deep)
        .cornerRadius(56)
        .padding([.leading, .trailing], 15)
        .padding([.top, .bottom], 10)
    }
    
    // ChatGPT 또는 User 중 누가 입력했는지에 따라 셀 구분
    @ViewBuilder
    private func dialogueCell(cellType: DialogueType, text: String) -> some View {
        switch cellType {
        case .fromUser:
            userDialogueCell(text)
        case .fromChatGPT:
            chatGPTDialogueCell(text)
        case .fromChatGPTWaiting:
            chatGPTWaitingCell
        case .fromChatGPTFail:
            chatGPTDialogueCell("현재 ChatGPT 서비스가 불안정합니다.")
        }
    }
    
    // ChatGPT 아이콘
    @ViewBuilder
    private var chatGPTIcon: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 28, height: 28)
            .foregroundColor(.Bg_ChatGPT)
            .overlay {
                Image(.chatgpt)
                    .resizable()
                    .frame(width: 18, height: 18)
            }
    }
    
    // ChatGPT가 대답해준 내용을 나타내는 셀
    @ViewBuilder
    private func chatGPTDialogueCell(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            chatGPTIcon
            Text(text)
                .font(.Body3Regular)
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 12)
                .background(.Bg_Dark_Deep)
                .foregroundColor(.Text_Serve)
                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    // ChatGPT가 대답해준 내용을 나타내는 셀
    @ViewBuilder
    private var chatGPTWaitingCell: some View {
        HStack(alignment: .top, spacing: 12) {
            chatGPTIcon
            LottieView(filename: "loading")
                .frame(width: 80, height: 40)
                .background(.Bg_Dark_Deep)
                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    // 유저가 물어본 내용을 나타내는 셀
    @ViewBuilder
    private func userDialogueCell(_ text: String) -> some View {
        Text(text)
            .font(.Body2Regular)
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 12)
            .background(.Bg_Point)
            .foregroundColor(.white)
            .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
            .cornerRadius(2, corners: [.bottomRight])
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
