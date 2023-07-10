//
//  ProfileSettingView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/04.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct ProfileSettingView: View {
    @ObservedObject public var viewModel: ProfileSettingViewModel
    @FocusState private var focus: ProfileSettingViewModel.TextFieldCategory?
    @State private var imageData: Data? // 원래는 ViewModel에 정의하는게 맞지만, 이미지가 안바뀌는 버그가 발생하여 View에 정의
    
    public init(viewModel: ProfileSettingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            PhotoPicker(imageData: $imageData)
            setProfileTextFieldView(fieldCategory: .username, limitedText: $viewModel.username, focus: _focus)
            setProfileTextFieldView(fieldCategory: .nickname, limitedText: $viewModel.nickname, focus: _focus)
            setProfileTextFieldView(fieldCategory: .introduce, limitedText: $viewModel.introduce, focus: _focus)
            notifyErrorView()
            Spacer()
            finishButtonView()
        }
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
    
    // 이름 보여주는 뷰 (소셜 로그인 화면에서 넘겨받기)
    @ViewBuilder
    private func nameView(text: String?) -> some View {
        VStack {
            Text("이름")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 10))
                .padding(.bottom, 2)
            if let text {
                Text(text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            Divider()
        }
    }
    
    // 프로필 관련 텍스트 입력 뷰 (fieldCategory로 선택 가능)
    @ViewBuilder
    private func setProfileTextFieldView(fieldCategory: ProfileSettingViewModel.TextFieldCategory, limitedText: Binding<LimitedText>, focus: FocusState<ProfileSettingViewModel.TextFieldCategory?>) -> some View {
        
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
    
    // 에러 발생했을 시 보여주는 뷰
    @ViewBuilder
    private func notifyErrorView() -> some View {
        if let error = viewModel.uploadError {
            Text(error.localizedString)
                .foregroundColor(.red)
        } else {
            EmptyView()
        }
    }
    
    // 설정 완료 버튼 뷰
    @ViewBuilder
    private func finishButtonView() -> some View {
        Button {
            viewModel.imageData = imageData
            viewModel.moveToLearningHomeView()
        } label: {
            Text("설정하기")
        }
        .buttonStyle(.bordered)
        .tint(.orange)
        .padding(.bottom, 20)
    }
}
