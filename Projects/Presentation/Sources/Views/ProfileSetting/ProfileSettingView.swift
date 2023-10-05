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
    @FocusState private var focus: ProfileTextFieldCategory?
    
    public init(viewModel: ProfileSettingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(StringLiteral.profileSettingTitle)
                    .font(.Head1Bold)
                Spacer()
            }
            .padding(.top, 22)
            .padding(.bottom, 28)
            PhotoPickerView(imageData: $viewModel.imageData)
                .padding(.bottom, 30)
            profileTextField(fieldCategory: .username, limitedText: $viewModel.username, focus: _focus)
                .padding(.bottom, 30)
            profileTextField(fieldCategory: .nickname, limitedText: $viewModel.nickname, focus: _focus)
                .padding(.bottom, 30)
            profileTextField(fieldCategory: .introduce, limitedText: $viewModel.introduce, focus: _focus)
                .padding(.bottom, 30)
            textErrorMessage
            finishButton
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 20)
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
                    if focus == .introduce {
                        Text(StringLiteral.profileSettingFocusEnd)
                    } else {
                        Text(StringLiteral.profileSettingFocusNext)
                    }
                }
            }
        }
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
        .onAppear {
            viewModel.viewOnAppear()
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
                viewModel.onFinishButtonClicked()
            }
        } label: {
            Text(StringLiteral.profileSettingDoneButtonTitle)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .cornerRadius(6)
                .font(.Body1Medium)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.Button_Point)
                }
        }
        .padding(.top, 30)
    }
}
