//
//  MyPageView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct MyPageView: View {
    
    @StateObject var viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if let userInfo = viewModel.userInfo {
                headSection
                Divider()
                    .frame(minHeight: 10)
                    .overlay(.Divider_Default)
                listSection
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.getUserInfo()
        }
    }
    
    @ViewBuilder
    private var headSection: some View {
        if let userInfo = viewModel.userInfo {
            VStack(spacing: 0) {
                HStack {
                    Text("마이페이지")
                        .font(.Head1Bold)
                        .padding(.top, 22)
                    Spacer()
                }
                .padding(.bottom, 30)
                HStack(spacing: 14) {
                    PhotoPickerView(imageData: $viewModel.imageData)
                        .frame(width: 74, height: 74)
                        .clipShape(Circle())
                    VStack(spacing: 9) {
                        HStack {
                            Text("번개 다람쥐")
                                .font(.Head3SemiBold)
                                .foregroundColor(.Text_Default)
                            Spacer()
                            Button {
                                viewModel.moveToModifyProfileView()
                            } label: {
                                Text("정보수정")
                                    .font(.InfoRegular)
                                    .foregroundColor(.Text_Info)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(.Border_Default, lineWidth: 1)
                            )
                        }
                        HStack {
                            Text(userInfo.introduce)
                                .lineLimit(2)
                                .font(.Body3Regular)
                                .foregroundColor(.Text_Serve)
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: SymbolName.heartCircleFill)
                        .font(.system(size: 14))
                        .padding(.trailing, 8)
                    Text("내 포인트: ")
                        .font(.Body2Regular)
                        .foregroundColor(.Text_Default)
                    Spacer()
                    Text(String(userInfo.point) + "P")
                        .font(.Head2Bold)
                        .foregroundColor(.Text_Point)
                    Button {
                        // 충전 페이지로 이동
                    } label: {
                        Text("충전")
                            .font(.Body3SemiBold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 14 )
                            .fill(.Button_Point)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .background(
                    RoundedRectangle(cornerRadius: 14 )
                        .fill(.Bg_Point_Light)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.Border_Serve, lineWidth: 1)
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 27)
        }
    }
    
    @ViewBuilder
    private var listSection: some View {
        ScrollView {
            VStack(spacing: 0) {
                Divider()
                Group {
                    HStack(spacing: 10) {
                        Image(systemName: SymbolName.squareAndArrowDown)
                            .font(.system(size: 18))
                            .padding(.trailing, 8)
                        Text("업로드한 기출문제")
                            .font(.Body1Regular)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    Divider()
                    HStack(spacing: 10) {
                        Image(systemName: SymbolName.squareAndArrowDown)
                            .font(.system(size: 18))
                            .padding(.trailing, 8)
                        Text("구매한 기출문제")
                            .font(.Body1Regular)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    Divider()
                    HStack(spacing: 10) {
                        Image(systemName: SymbolName.bell)
                            .font(.system(size: 18))
                            .padding(.trailing, 8)
                        Toggle("알림받기", isOn: $viewModel.alarmStatus)
                            .toggleStyle(AlarmToggleStyle())
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                }
            }
            Divider()
            HStack {
                Spacer()
                Button("로그아웃") {
                    viewModel.postLogout()
                }
                Spacer()
            }
            .padding(20)
            Divider()
            HStack {
                Spacer()
                Button("회원탈퇴") {
                    // 회원탈퇴
                }
                Spacer()
            }
            .padding(20)
            Spacer()
        }
    }
}
