//
//  Coordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import KakaoSDKAuth

public enum Page: Hashable {
    case loginView, profileSettingView(String)
    case rootTabView
    case learningHomeView, learningCategoryView
    case prevProblemCategoryView
    case myPageView
    
    @ViewBuilder
    public func getView(viewResolver: ViewResolverProtocol) -> some View {
        switch self {
        case .loginView:
            viewResolver.resolveView(LoginView.self)
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                })
        case .profileSettingView(let name):
            setDataInProfileSettingView(viewResolver: viewResolver, name: name)
        case .learningHomeView:
            viewResolver.resolveView(LearningHomeView.self)
        case .learningCategoryView:
            viewResolver.resolveView(LearningCategoryView.self)
        case .prevProblemCategoryView:
            viewResolver.resolveView(PrevProblemCategoryView.self)
        case .myPageView:
            viewResolver.resolveView(MyPageView.self)
        case .rootTabView:
            viewResolver.resolveView(RootTabView.self)
        }
    }
    
    func setDataInProfileSettingView(viewResolver: ViewResolverProtocol, name: String) -> ProfileSettingView {
        let view = viewResolver.resolveView(ProfileSettingView.self)
        view.viewModel.userName = name
        return view
    }
    
}
