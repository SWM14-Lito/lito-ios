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
    private let initialScene: AppScene
    var injector: Injector?
    
    public init(_ initialScene: AppScene) {
        self.initialScene = initialScene
        self.path = NavigationPath([initialScene])
    }
    
    public func buildInitialScene() -> some View {
        return buildScene(scene: initialScene)
    }
    
    public func push(_ scene: AppScene) {
        path.append(scene)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    public func buildScene(scene: AppScene) -> some View {
        switch scene {
        case .loginScene:
            injector?.resolve(LoginView.self)
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                })
        case .profileSettingScene:
            injector?.resolve(ProfileSettingView.self)
        case .learningHomeScene:
            injector?.resolve(LearningHomeView.self)
        case .problemListScene:
            injector?.resolve(ProblemListView.self)
        case .problemSolvingScene(let id):
            injector?.resolve(ProblemSolvingView.self, argument: id)
        case .pedigreeListScene:
            injector?.resolve(PedigreeListView.self)
        case .myPageScene:
            injector?.resolve(MyPageView.self)
        case .rootTabScene:
            injector?.resolve(RootTabView.self)
        }
    }
}
