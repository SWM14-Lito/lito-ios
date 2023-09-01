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
            errorMessage
            HStack {
                Text("프로필 설정")
                    .font(.Head1Bold)
                Spacer()
            }
                .padding(.top, 22)
                .padding(.bottom, 28)
            PhotoPickerView(imageData: $viewModel.imageData)
                .padding(.bottom, 30)
            profileTextField(fieldCategory: .username, limitedText: $viewModel.username, errorMessage: viewModel.textErrorMessage, focus: _focus)
                .padding(.bottom, 30)
            profileTextField(fieldCategory: .nickname, limitedText: $viewModel.nickname, errorMessage: viewModel.textErrorMessage, focus: _focus)
                .padding(.bottom, 30)
            profileTextField(fieldCategory: .introduce, limitedText: $viewModel.introduce, errorMessage: viewModel.textErrorMessage, focus: _focus)
                .padding(.bottom, 30)
            textErrorMessage
            Button {
                if !viewModel.buttonIsLocked {
                    viewModel.requestNotiAndMoveToLearningHomeView()
                }
            } label: {
                Text("완료")
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
                        Text("Done")
                    } else {
                        Text("Next")
                    }
                }
            }
        }
        .onAppear {
            viewModel.viewOnAppear()
        }
    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
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
                viewModel.requestNotiAndMoveToLearningHomeView()
            }
        } label: {
            Text("설정하기")
        }
        .buttonStyle(.bordered)
        .tint(.orange)
        .padding(.bottom, 20)
    }
}
