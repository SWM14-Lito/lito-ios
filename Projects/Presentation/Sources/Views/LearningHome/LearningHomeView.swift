//
//  LearningHomeView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct LearningHomeView: View {
    
    @StateObject private var viewModel: LearningHomeViewModel
    
    public init(viewModel: LearningHomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                gradient: Gradient(colors: [
                    .Gradation_TopLeading, .Gradation_BottonTrailing
                ]),
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .frame(height: 283)
            .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
            VStack {
                HStack(alignment: .top) {
                    profile
                    Spacer()
                    toolMenu
                }
                .padding(.top, 50)
                .padding(.bottom, 16)
                learningGoal
                Spacer()
                
                //            errorMessage
                //            profile
                //            startLearningButton
                //            Divider()
                //            solvingProblem
                //            Spacer()
            }
            .padding([.leading, .trailing], 20)
        }
        .edgesIgnoringSafeArea(.all)
        .background(.Bg_Light)
        .onAppear {
            if !viewModel.isViewFirstAppeared {
                viewModel.setViewFirstAppeared()
                viewModel.getProfileAndProblems()
            }
            viewModel.getProblemMutable()
        }
        
    }
    
    // API 에러 발생시 알려줌
    @ViewBuilder
    private var errorMessage: some View {
        ErrorView(errorObject: viewModel.errorObject)
    }
    
    // 프로필 이미지와 닉네임 보여주기 *
    @ViewBuilder
    private var profile: some View {
        VStack(alignment: .leading) {
            if let userInfo = viewModel.userInfo {
                UrlImageView(urlString: userInfo.profileImgUrl)
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
                HStack {
                    Text(userInfo.nickname)
                        .fontWeight(.bold)
                    Text("님,")
                }
            }
            Text("오늘도 목표를 달성하세요!")
        }
        .font(.system(size: 22))
    }
    
    // 찜한 목록, 알림 목록으로 이동할 수 있는 툴바 버튼 *
    @ViewBuilder
    private var toolMenu: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.moveToFavoriteProblemView()
            } label: {
                Image(systemName: SymbolName.favoriteList)
                    .font(.system(size: 24))
            }
            Button {
                viewModel.moveToNotiView()
            } label: {
                Image(systemName: SymbolName.notiList)
                    .font(.system(size: 24))
            }
        }
    }
    
    // 학습 목표
    @ViewBuilder
    private var learningGoal: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.Bg_Default)
                .cornerRadius(16)
                .shadow(color: .Shadow_Default, radius: 6, x: 0, y: 4)
            VStack(spacing: 16) {
                HStack {
                    learningRateProgressBar
                    VStack(alignment: .leading, spacing: 5) {
                        Text("오늘의 학습목표")
                            .font(.system(size: 16, weight: .bold))
                        HStack {
                            Text("하루목표")
                                .font(.system(size: 14))
                            Spacer()
                            goalSettingPicker
                        }
                    }
                    .padding(.leading, 17)
                }
                startLearningButton
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: 196)
    }
    
    // 학습 진행률 프로그래스 바 *
    @ViewBuilder
    private var learningRateProgressBar: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .foregroundColor(.Border_Default)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(viewModel.learningRate, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(.Button_Point)
                .rotationEffect(Angle(degrees: 270.0))
            
            HStack {
                Text(String(format: "%.0f%", min(viewModel.learningRate, 1.0)*100.0))
                    .font(.system(size: 26))
                    .bold()
                Text("%")
                    .font(.system(size: 12))
            }
        }
        .frame(width: 88, height: 88)
    }
    
    // 학습 목표 설정 피커
    @ViewBuilder
    private var goalSettingPicker: some View {
        Menu {
            Picker(selection: $viewModel.goalCount, label: EmptyView(), content: {
                ForEach(0 ..< 11) { number in
                    Text("\(number)").tag(number)
                }
            }).pickerStyle(.automatic)
        }label: {
            HStack {
                Text("\(viewModel.goalCount) 개")
                    .font(.system(size: 14))
                Image(systemName: SymbolName.chevronDown)
                    .font(.system(size: 6, weight: .bold))
            }
            .frame(width: 70, height: 30)
            .foregroundColor(.Text_Serve)
            .background(.Bg_Picker)
            .buttonStyle(.bordered)
            .cornerRadius(17)
        }
        .padding(.trailing, 4)
        
    }
    
    // 학습 시작 버튼 *
    @ViewBuilder
    private var startLearningButton: some View {
        Button {
            viewModel.moveToLearningView()
        } label: {
            Text("학습시작")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.Text_White)
                .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .buttonStyle(.bordered)
        .background(.Button_Point)
        .cornerRadius(46)
    }
    
    // 풀던 문제 보여주기
    @ViewBuilder
    private var solvingProblem: some View {
        if viewModel.isGotResponse {
            if viewModel.solvingProblem != nil {
                VStack(alignment: .leading) {
                    HStack {
                        Text("풀던 문제")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        Button {
                            viewModel.moveToSolvingProblemView()
                        } label: {
                            Text("전체 보기")
                        }
                    }
                    ProblemCellView(problemCellVO: $viewModel.solvingProblem.toUnwrapped(), problemCellHandling: viewModel)
                }
                .padding([.leading, .trailing], 20)
            } else {
                Text("진행중인 문제가 없습니다.")
                    .padding()
            }
        } else {
            Spacer()
            ProgressView()
        }
    }
}
