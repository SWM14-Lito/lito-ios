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
            gradientBackground
            content
            progressBar
            #if DEBUG
            errorMessage
            #endif
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.theme.Bg_Light)
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
    
    // 그라디언트 배경
    @ViewBuilder
    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.theme.Gradation_TopLeading, Color.theme.Gradation_BottonTrailing
            ]),
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .frame(height: 283)
        .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
    }
    
    // 서버에서 데이터 받아오는 동안 보여주는 로딩바
    @ViewBuilder
    private var progressBar: some View {
        if !viewModel.isGotResponse {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
    
    // 실제 화면에 보여줄 컨텐츠
    @ViewBuilder
    private var content: some View {
        VStack {
            header
            learningGoal
            ScrollView {
                solvingProblem
                recommendedProblem
                    .padding(.bottom, 20)
            }
            .scrollIndicators(.hidden)
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .padding(.bottom, 77) // 탭바 사이즈 알아오는 코드 필요
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
        if let userInfo = viewModel.userInfo {
            VStack(alignment: .leading) {
                UrlImageView(urlString: userInfo.profileImgUrl)
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
                HStack {
                    Text(userInfo.nickname)
                        .fontWeight(.heavy)
                    Text("님,")
                }
                Text("오늘도 목표를 달성하세요!")
            }
            .foregroundColor(Color.theme.Text_White)
            .font(.system(size: 22))
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
                viewModel.moveToFavoriteProblemView()
            } label: {
                Image(systemName: SymbolName.favoriteList)
                    .font(.system(size: 24))
                    .foregroundColor(Color.theme.Button_White)
            }
            Button {
                viewModel.moveToNotiView()
            } label: {
                Image(systemName: SymbolName.notiList)
                    .font(.system(size: 24))
                    .foregroundColor(Color.theme.Button_White)
            }
        }
    }
    
    // 학습 목표
    @ViewBuilder
    private var learningGoal: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(Color.theme.Bg_Default)
                .cornerRadius(16)
                .shadow(color: Color.theme.Shadow_Default, radius: 6, x: 0, y: 4)
            VStack(spacing: 16) {
                if viewModel.isGotResponse {
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
                .foregroundColor(Color.theme.Border_Default)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(viewModel.learningRate, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.theme.Button_Point)
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
            .foregroundColor(Color.theme.Text_Serve)
            .background(Color.theme.Bg_Picker)
            .buttonStyle(.bordered)
            .cornerRadius(17)
        }
        .padding(.trailing, 4)
    }
    
    // 학습 시작 버튼
    @ViewBuilder
    private var startLearningButton: some View {
        Button {
            viewModel.moveToLearningView()
        } label: {
            Text("학습시작")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.theme.Text_White)
                .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .buttonStyle(.bordered)
        .background(Color.theme.Button_Point)
        .cornerRadius(46)
    }
    
    // 풀던 문제 보여주기
    @ViewBuilder
    private var solvingProblem: some View {
        if viewModel.isGotResponse {
            VStack(spacing: 10) {
                HStack {
                    Text("풀던 문제")
                        .foregroundColor(Color.theme.Text_Default)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    if viewModel.solvingProblem != nil {
                        Button {
                            viewModel.moveToSolvingProblemView()
                        } label: {
                            HStack(spacing: 4) {
                                Text("전체 보기")
                                Image(systemName: SymbolName.chevronRight)
                            }
                            .foregroundColor(Color.theme.Text_Serve)
                            .font(.system(size: 12))
                        }
                    }
                }
                if viewModel.solvingProblem != nil {
                    ProblemCellView(problemCellVO: $viewModel.solvingProblem.toUnwrapped(), problemCellHandling: viewModel)
                } else {
                    Text("진행중인 문제가 없습니다.")
                        .padding()
                }
            }
            .padding(.top, 38)
        }
    }
    
    // 추천 문제 보여주기
    @ViewBuilder
    private var recommendedProblem: some View {
        if viewModel.isGotResponse {
            VStack(spacing: 10) {
                HStack {
                    Text("추천 문제")
                        .foregroundColor(Color.theme.Text_Default)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                if viewModel.recommendedProblem != nil {
                    VStack(spacing: 8) {
                        ForEach($viewModel.recommendedProblem.toUnwrapped(), id: \.self) { problem in
                            ProblemCellView(problemCellVO: problem, problemCellHandling: viewModel)
                        }
                    }
                } else {
                    Text("추천 문제가 없습니다.")
                        .padding()
                }
            }
            .padding(.top, 27)
        }
    }
}
