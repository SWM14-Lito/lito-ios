//
//  ChatGPTView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/28.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

public struct ChatGPTView: View {
    
    @StateObject private var viewModel: ChatGPTViewModel
    @FocusState private var focused: Bool
    
    public init(viewModel: ChatGPTViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            closeButton
            dialogueList
            Divider()
            questionTextfield
        }
        .onAppear {
            focused = true
        }
        .interactiveDismissDisabled()
    }
    
    // 모달 닫는 버튼
    @ViewBuilder
    private var closeButton: some View {
        HStack {
            Spacer()
            Button {
                viewModel.dismissSheet()
            } label: {
                Text("닫기")
            }
            .padding()
        }
    }
    
    // 대화 보여주기
    @ViewBuilder
    private var dialogueList: some View {
        ScrollView {
            ScrollViewReader { value in
                ForEach(viewModel.dialogue.indices, id: \.self) { index in
                    let dialogueUnit = viewModel.dialogue[index]
                    dialogueCell(cellType: dialogueUnit.dialogueType, text: dialogueUnit.text)
                        .id(index)
                }
                .onChange(of: viewModel.dialogue.count) { _ in
                    value.scrollTo(viewModel.dialogue.count - 1)
                }
            }
        }
        .padding(.top)
    }
    
    // 질문 입력하기
    @ViewBuilder
    private var questionTextfield: some View {
        HStack {
            TextField("ChatGPT에게 궁금한 점을 질문해보세요!", text: $viewModel.input)
                .padding()
                .focused($focused)
            Spacer()
            Button {
                viewModel.sendQuestion()
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    viewModel.getAnswer()
                }
            } label: {
                Text("보내기")
            }
            .padding(.trailing)
        }
    }
    
    // ChatGPT 또는 User 중 누가 입력했는지에 따라 셀 구분
    @ViewBuilder
    private func dialogueCell(cellType: DialogueType, text: String) -> some View {
        HStack {
            if cellType == .fromChatGPT {
                chatGPTDialogueCell(text)
            } else {
                userDialogueCell(text)
            }
        }
        .padding([.leading, .trailing])
    }
    
    // ChatGPT가 대답해준 내용을 나타내는 셀
    @ViewBuilder
    private func chatGPTDialogueCell(_ text: String) -> some View {
        Text(text)
            .frame(width: 300)
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
        Spacer()
    }
    
    // 유저가 물어본 내용을 나타내는 셀
    @ViewBuilder
    private func userDialogueCell(_ text: String) -> some View {
        Spacer()
        Text(text)
            .frame(width: 300)
            .padding()
            .background(.orange)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}
