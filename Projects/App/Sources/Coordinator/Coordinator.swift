//
//  AppCoordinator.swift
//  App
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Presentation
import KakaoSDKAuth
import Domain

public class Coordinator: ObservableObject, CoordinatorProtocol {
    @Published public var path: NavigationPath
    private let initialPage: Page
    var injector: Injector?
    
    public init(_ initialPage: Page) {
        self.initialPage = initialPage
        self.path = NavigationPath([initialPage])
    }
    
    public func buildInitialPage() -> some View {
        return buildPage(page: initialPage)
    }
    
    public func push(_ page: Page) {
        path.append(page)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    public func buildPage(page: Page) -> some View {
        switch page {
        case .loginView:
            injector?.resolve(LoginView.self)
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                })
        case .profileSettingView:
            injector?.resolve(ProfileSettingView.self)
        case .learningHomeView:
            injector?.resolve(LearningHomeView.self)
        case .problemListView:
            injector?.resolve(ProblemListView.self)
        case .problemSolvingView(let id):
            buildProblemSolvingPage(id: id)
        case .pedigreeListView:
            injector?.resolve(PedigreeListView.self)
        case .myPageView:
            injector?.resolve(MyPageView.self)
        case .rootTabView:
            injector?.resolve(RootTabView.self)
        }
    }
    
    // 파라미터 넘겨줘야 하는 화면 전환 시 해당 방법 사용
    // injector에서 View가 아닌 ViewModel을 꺼내 쓰는 것이 좀 걸리지만, 다른 방법이 생각이 나지 않음
    // (View 꺼내서 view.viewmodel.setProblemId 방식은 StateObject 관련 런타임 오류 발생)
    private func buildProblemSolvingPage(id: Int) -> ProblemSolvingView? {
        let viewModel = injector?.resolve(ProblemSolvingViewModel.self)
        viewModel?.setProblemId(id: id)
        return ProblemSolvingView(viewModel: viewModel!)
    }
}
