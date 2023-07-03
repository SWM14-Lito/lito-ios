//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct RootTabView: View {
    
    private var coordinator: CoordinatorProtocol
    private let viewResolver: ViewResolverProtocol
    @State private var navigationPath = NavigationPath()
    
    public init(coordinator: CoordinatorProtocol, viewResolver: ViewResolverProtocol) {
        self.coordinator = coordinator
        self.viewResolver = viewResolver
    }
    
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            TabView {
                viewResolver.resolveView(LearningHomeView.self)
                    .tabItem { Text("학습") }
                viewResolver.resolveView(PrevProblemCategoryView.self)
                    .tabItem { Text("기출문제") }
                viewResolver.resolveView(MyPageView.self)
                    .tabItem { Text("마이페이지") }
            }
            .navigationDestination(for: Page.self) { page in
                page.getView(coordinator: coordinator, viewResolver: viewResolver)
            }
        }
        .onReceive(coordinator.pathPublisher) { navigationPath in
            self.navigationPath = navigationPath
            print("push!!")
        }
    }
}
