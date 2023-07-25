//
//  ProfileSettingView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/04.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct ProfileSettingView: View {
    @StateObject private var viewModel: ProfileSettingViewModel
    @FocusState private var focus: ProfileSettingViewModel.TextFieldCategory?
    
    public init(viewModel: ProfileSettingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            errorMessage
            PhotoPickerView(imageData: $viewModel.imageData)
            profileTextField(fieldCategory: .username, limitedText: $viewModel.username, focus: _focus)
            profileTextField(fieldCategory: .nickname, limitedText: $viewModel.nickname, focus: _focus)
            profileTextField(fieldCategory: .introduce, limitedText: $viewModel.introduce, focus: _focus)
            textErrorMessage
            Spacer()
            finishButton
        }
        .navigationBarBackButtonHidden(true)
        .padding([.leading, .trailing], 15)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    switch focus {
                    case .username:
                        focus = .nickname
                    case .nickname:
                        focus = .introduce
                    case .introduce:
                        focus = nil
                    case .none:
                        break
                    }
                } label: {
                    Text("Done")
                }
            }
        }
    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
    
    // 프로필 관련 텍스트 입력 (fieldCategory로 선택 가능 - 이름, 닉네임, 소개글)
    @ViewBuilder
    private func profileTextField(fieldCategory: ProfileSettingViewModel.TextFieldCategory, limitedText: Binding<LimitedText>, focus: FocusState<ProfileSettingViewModel.TextFieldCategory?>) -> some View {
        
        let curLength = String(limitedText.wrappedValue.text.count)
        let maxLength = String(limitedText.wrappedValue.limit)
        let isExceed = viewModel.isExceedLimit[fieldCategory] ?? false
        
        VStack {
            Text(fieldCategory.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 10))
            ZStack(alignment: .bottomTrailing) {
                TextField(fieldCategory.placeHolder, text: limitedText.projectedValue.text, axis: .vertical)
                    .font(.system(size: 15))
                    .padding(.trailing, 70)
                    .focused($focus, equals: fieldCategory)
                HStack {
                    Text(curLength + "/" + maxLength)
                        .font(.system(size: 10))
                        .foregroundColor(isExceed ? .red : .black)
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            limitedText.projectedValue.text.wrappedValue = ""
                        }
                }
            }
            Divider()
        }
    }
    
    // 텍스트 입력 관련 오류 메시지 띄워줌
    @ViewBuilder
    private var textErrorMessage: some View {
        if let msg = viewModel.textErrorMessage {
            Text(msg)
                .foregroundColor(.red)
        }
    }
    
    // 설정 완료 버튼
    @ViewBuilder
    private var finishButton: some View {
        Button {
            if !viewModel.buttonIsLocked {
                viewModel.moveToLearningHomeView()
            }
        } label: {
            Text("설정하기")
        }
        .buttonStyle(.bordered)
        .tint(.orange)
        .padding(.bottom, 20)
    }
}
