//
//  AppCoordinator.swift
//  App
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import UIKit
import SwiftUI
import Presentation
import KakaoSDKAuth
import Domain

public class Coordinator: ObservableObject, CoordinatorProtocol {
    @Published public var path: NavigationPath
    @Published public var sheet: AppScene?
    private let initialScene: AppScene
    var injector: Injector?
    
    public init(_ initialScene: AppScene) {
        self.initialScene = initialScene
        self.path = NavigationPath()
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
    
    public func present(sheet: AppScene) {
        self.sheet = sheet
    }
    
    public func dismissSheet() {
        self.sheet = nil
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
        case .profileSettingScene(let userAuthVO):
            injector?.resolve(ProfileSettingView.self, argument: userAuthVO)
        case .learningHomeScene:
            injector?.resolve(LearningHomeView.self)
        case .problemListScene:
            injector?.resolve(ProblemListView.self)
        case .problemDetailScene(let id):
            injector?.resolve(ProblemDetailView.self, argument: id)
        case .pedigreeListScene:
            injector?.resolve(PedigreeListView.self)
        case .solvingProblemListScene:
            injector?.resolve(SolvingProblemListView.self)
        case .favoriteProblemListScene:
            injector?.resolve(FavoriteProblemListView.self)
        case .myPageScene:
            injector?.resolve(MyPageView.self)
        case .rootTabScene:
            injector?.resolve(RootTabView.self)
        case .chattingScene(let question, let answer, let problemId):
            injector?.resolve(ChattingView.self, arguments: question, answer, problemId)
        case .problemSearchScene:
            injector?.resolve(ProblemSearchView.self)
        case .modifyProfileScene:
            injector?.resolve(ModifyProfileView.self)
        }
    }
    
    @ViewBuilder
    public func buildSheet(scene: AppScene) -> some View {
        NavigationStack {
            buildScene(scene: scene)
        }
    }
}

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 2
    }
}
