//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct RootTabView: View {
    
    private var coordinator: any CoordinatorProtocol
    @State private var navigationPath = NavigationPath()
    
    public init(coordinator: any CoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            TabView {
                LearningHomeView(viewModel: LearningHomeViewModel(coordinator: coordinator))
                    .tabItem { Text("학습") }
                PrevProblemCategoryView(viewModel: PrevProblemCategoryViewModel(coordinator: coordinator))
                    .tabItem { Text("기출문제") }
                MyPageView(viewModel: MyPageViewModel(coordinator: coordinator))
                    .tabItem { Text("마이페이지") }
            }
            .navigationDestination(for: Page.self) { page in
                page.getView(coordinator: coordinator)
            }
        }
        .onReceive(coordinator.pathPublisher) { navigationPath in
            self.navigationPath = navigationPath
        }
    }
}
