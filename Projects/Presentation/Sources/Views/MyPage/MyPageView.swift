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
            if viewModel.userInfo != nil {
                headSection
                Divider()
                    .frame(minHeight: 10)
                    .overlay(.Divider_Default)
                listSection
            } else {
                LoadingView()
            }
        }
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
        .onAppear {
            viewModel.onScreenAppeared()
        }
    }
    
    @ViewBuilder
    private var headSection: some View {
        if let userInfo = viewModel.userInfo {
            VStack(spacing: 0) {
                HStack {
                    Text(StringLiteral.mypage)
                        .font(.Head1Bold)
                        .padding(.top, 22)
                    Spacer()
                }
                .padding(.bottom, 30)
                HStack(spacing: 14) {
                    PhotoPickerView(imageData: $viewModel.imageData, photoPickerHandling: viewModel)
                        .frame(width: 74, height: 74)
                        .transaction { transaction in
                            transaction.animation = nil
                        }
                    VStack(spacing: 9) {
                        HStack {
                            Text(userInfo.nickname)
                                .font(.Head3SemiBold)
                                .foregroundColor(.Text_Default)
                            Spacer()
                            Button {
                                viewModel.onEditButtonClicked()
                            } label: {
                                Text(StringLiteral.mypageChangeInfo)
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
//                HStack {
//                    Image(.iconPoint)
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                        .padding(.trailing, 8)
//                    Text(StringLiteral.myPageMypoint)
//                        .font(.Body2Regular)
//                        .foregroundColor(.Text_Default)
//                    Spacer()
//                    Text(String(userInfo.point) + "P")
//                        .font(.Head2Bold)
//                        .foregroundColor(.Text_Point)
//                    Button {
//                        // 충전 페이지로 이동
//                    } label: {
//                        Text(StringLiteral.myPageCharge)
//                            .font(.Body3SemiBold)
//                            .foregroundColor(.white)
//                    }
//                    .padding(.horizontal, 13)
//                    .padding(.vertical, 6)
//                    .background(
//                        RoundedRectangle(cornerRadius: 14 )
//                            .fill(.Button_Point)
//                    )
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 24)
//                .background(
//                    RoundedRectangle(cornerRadius: 14 )
//                        .fill(.Bg_Point_Light)
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 14)
//                        .stroke(.Border_Serve, lineWidth: 1)
//                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 27)
        }
    }
    
    @ViewBuilder
    private var listSection: some View {
        VStack(spacing: 0) {
            Divider()
            Group {
//                HStack(spacing: 10) {
//                    Image(systemName: SymbolName.squareAndArrowDown)
//                        .font(.system(size: 18))
//                        .padding(.trailing, 8)
//                    Text(StringLiteral.myPageUploadedProblem)
//                        .font(.Body1Regular)
//                    Spacer()
//                    Image(systemName: SymbolName.chevronRight)
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 18)
//                Divider()
//                HStack(spacing: 10) {
//                    Image(systemName: SymbolName.squareAndArrowDown)
//                        .font(.system(size: 18))
//                        .padding(.trailing, 8)
//                    Text(StringLiteral.myPagePurchasedProblem)
//                        .font(.Body1Regular)
//                    Spacer()
//                    Image(systemName: SymbolName.chevronRight)
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 18)
//                Divider()
                HStack(spacing: 10) {
                    Image(systemName: SymbolName.bell)
                        .font(.system(size: 18))
                        .padding(.trailing, 8)
                    Toggle(StringLiteral.myPageAcceptAlarm, isOn: $viewModel.alarmStatus)
                        .toggleStyle(AlarmToggleStyle())
                        .onChange(of: viewModel.alarmStatus) { _ in
                            viewModel.onAlarmAcceptanceChanged()
                        }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
            }
        }
        Divider()
        Spacer()
        Button {
            viewModel.onLogoutButtonClicked()
        } label: {
            Text(StringLiteral.logout)
                .underline()
                .font(.Body2Regular)
                .foregroundColor(.Text_Info)
        }
        .padding(.bottom, 30)
    }
}
