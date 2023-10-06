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
    @State private var tabBarHeight: CGFloat = 100
    
    public init(viewModel: LearningHomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            gradientBackground
            content
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(.Bg_Light)
        .onAppear {
            viewModel.onScreenAppeared()
        }
        .modifier(ErrorAlert(presentAlert: $viewModel.presentErrorAlert, message: viewModel.errorMessageForAlert, action: viewModel.lastNetworkAction))
    }
    
    // 그라디언트 배경
    @ViewBuilder
    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .Gradation_TopLeading, .Gradation_BottonTrailing
            ]),
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .frame(height: 283)
        .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
    }
    
    // 실제 화면에 보여줄 컨텐츠
    @ViewBuilder
    private var content: some View {
        VStack {
            header
            learningGoal
            ScrollView {
                processProblemArea
                recommendedProblemArea
                    .padding(.bottom, 10)
            }
            .scrollIndicators(.hidden)
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .background(TabBarAccessor { tabBar in
            tabBarHeight = tabBar.bounds.height
        })
        .padding(.bottom, tabBarHeight)
    }
    
    // 프로필 및 툴 버튼이 있는 헤더
    @ViewBuilder
    private var header: some View {
        HStack(alignment: .top) {
            profile
            Spacer()
            toolMenu
        }
        .padding(.top, 50)
        .padding(.bottom, 16)
    }
    
    // 프로필 이미지와 닉네임 보여주기
    @ViewBuilder
    private var profile: some View {
        if let learningHomeVO = viewModel.learningHomeVO {
            VStack(alignment: .leading) {
                UrlImageView(urlString: learningHomeVO.profileImgUrl)
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
                HStack(spacing: 0) {
                    Text(learningHomeVO.nickname)
                        .font(.Head1Bold)
                    Text("님,")
                        .font(.Head1Light)
                }
                Text("오늘도 목표를 달성하세요!")
                    .font(.Head1Light)
            }
            .foregroundColor(.white)
        } else {
            Spacer()
                .frame(height: 118)
        }
    }
    
    // 찜한 목록, 알림 목록으로 이동할 수 있는 툴바 버튼
    @ViewBuilder
    private var toolMenu: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.onFavoriteListButtonClicked()
            } label: {
                Image(systemName: SymbolName.heartFill)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            Button {
                viewModel.onNotiListButtonClicked()
            } label: {
                Image(systemName: SymbolName.bellFill)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
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
                if !viewModel.isLoading {
                    HStack {
                        learningRateProgressBar
                        VStack(alignment: .leading, spacing: 5) {
                            Text("오늘의 학습목표")
                                .font(.Body1SemiBold)
                            HStack {
                                Text("하루목표")
                                    .font(.Body2Regular)
                                Spacer()
                                goalSettingPicker
                            }
                        }
                        .padding(.leading, 17)
                    }
                }
                startLearningButton
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: 196)
    }
    
    // 학습 진행률 프로그래스 바
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
                    .font(.ProgressBarSemiBold)
                Text("%")
                    .font(.InfoRegular)
            }
        }
        .frame(width: 88, height: 88)
    }
    
    // 학습 목표 설정 피커
    @ViewBuilder
    private var goalSettingPicker: some View {
        Menu {
            Picker(selection: $viewModel.goalCount, label: EmptyView(), content: {
                ForEach(1 ..< 11) { number in
                    Text("\(number)").tag(number)
                }
            }).pickerStyle(.automatic)
        }label: {
            HStack {
                Text("\(viewModel.goalCount) 개")
                    .font(.Body2Regular)
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
    
    // 학습 시작 버튼
    @ViewBuilder
    private var startLearningButton: some View {
        Button {
            viewModel.onStartLearningButtonClicked()
        } label: {
            Text("학습시작")
                .font(.Body1SemiBold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .buttonStyle(.bordered)
        .background(.Button_Point)
        .cornerRadius(46)
    }
    
    // 풀던 문제 보여주기
    @ViewBuilder
    private var processProblemArea: some View {
        if !viewModel.isLoading {
            VStack(spacing: 10) {
                HStack {
                    Text("풀던 문제")
                        .foregroundColor(.Text_Default)
                        .font(.Head2Bold)
                    Spacer()
                    if viewModel.processProblem != nil {
                        Button {
                            viewModel.onSolvingListButtonClicked()
                        } label: {
                            HStack(spacing: 4) {
                                Text("전체 보기")
                                Image(systemName: SymbolName.chevronRight)
                            }
                            .foregroundColor(.Text_Serve)
                            .font(.InfoRegular)
                        }
                    }
                }
                if viewModel.processProblem != nil {
                    ProblemCellView(problemCellVO: $viewModel.processProblem.toUnwrapped(), problemCellHandling: viewModel)
                } else {
                    NoContentView(message: "풀던 문제가 없습니다.", withSymbol: false)
                }
            }
            .padding(.top, 38)
        }
    }
    
    // 추천 문제 보여주기
    @ViewBuilder
    private var recommendedProblemArea: some View {
        if !viewModel.isLoading {
            VStack(spacing: 10) {
                HStack {
                    Text("추천 문제")
                        .foregroundColor(.Text_Default)
                        .font(.Head2Bold)
                    Spacer()
                }
                if !viewModel.recommendProblems.isEmpty {
                    VStack(spacing: 8) {
                        ForEach($viewModel.recommendProblems, id: \.self) { problem in
                            ProblemCellView(problemCellVO: problem, problemCellHandling: viewModel)
                        }
                    }
                } else {
                    NoContentView(message: "추천 문제가 없습니다.", withSymbol: false)
                }
            }
            .padding(.top, 27)
        }
    }
}
