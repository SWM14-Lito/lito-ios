//
//  ModifyProfileView.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public struct ModifyProfileView: View {
    @ObservedObject private(set) var viewModel: MyPageViewModel
    @FocusState var nicknameFocused: Bool
    @FocusState var introduceFocused: Bool
    @State var presentCustomAlert = false
    
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        if let userInfo = viewModel.userInfo {
            ZStack {
                Color.white
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        nicknameFocused = false
                        introduceFocused = false
                    }
                VStack {
                    Divider()
                        .foregroundColor(.Divider_Default)
                        .padding(.top, 15)
                        .padding(.bottom, 39)
                    VStack(spacing: 0) {
                        // 이름
                        VStack(spacing: 0) {
                            HStack {
                                Text("이름")
                                    .font(.Body2SemiBold)
                                Spacer()
                            }
                            .padding(.bottom, 6)
                            HStack {
                                Text(userInfo.name)
                                    .font(.Body2Regular)
                                    .foregroundColor(.Text_Disabled)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.Bg_Deep)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.Border_Default, lineWidth: 1)
                            )
                        }
                        .padding(.bottom, 6)
                        HStack {
                            Text("이름 변경을 원하실 경우 이메일로 문의해주세요!")
                                .font(.InfoRegular)
                                .foregroundColor(.Text_Info)
                            Spacer()
                            Text("문의하기")
                                .font(.InfoRegular)
                                .foregroundColor(.Text_Point)
                                .underline()
                        }
                        .padding(.bottom, 30)
                        // 닉네임
                        profileTextField(fieldCategory: .nickname, limitedText: $viewModel.modifyNickNameInput, errorMessage: nil)
                            .padding(.bottom, 30)
                            .focused($nicknameFocused)
                        profileTextField(fieldCategory: .introduce, limitedText: $viewModel.modifyIntroduceInput, errorMessage: nil)
                            .focused($introduceFocused)
                        Spacer()
                        HStack(spacing: 12) {
                            Button {
                                presentCustomAlert.toggle()
                            } label: {
                                Text("회원탈퇴")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 20)
                                    .cornerRadius(6)
                                    .font(.Body1Medium)
                                    .foregroundColor(.white)
                                    .background {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(.Button_Negative)
                                    }
                            }
                            Button {
                                viewModel.patchUserInfo()
                            } label: {
                                Text("수정완료")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 20)
                                    .cornerRadius(6)
                                    .font(.Body1Medium)
                                    .foregroundColor(.white)
                                    .background {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(.Button_Point)
                                    }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                }
                if presentCustomAlert {
                    CustomAlert(presentAlert: $presentCustomAlert, alertTitle: "회원탈퇴", alertContent: "정말 탈퇴하시겠습니까?", leftButtonTitle: "취소", rightButtonTitle: "탈퇴", rightButtonAction: viewModel.deleteUser, alertStyle: .destructive)
                }
            }
            .modifier(CustomNavigation(title: "정보 수정", back: viewModel.back))
            .ignoresSafeArea(.keyboard)
        } else {
            EmptyView()
        }
    }
}
