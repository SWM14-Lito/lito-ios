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
