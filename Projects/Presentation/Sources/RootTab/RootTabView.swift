//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

// View와 ViewModel로 나눠보려했지만 실패 (navigationDestination에서 모든 뷰가 가능해서 viewModel에서 any View를 반환해봤지만 문법적 에러 발생)
public struct RootTabView: View {
    
    private var coordinator: Coordinator
    @State private var navigationPath = NavigationPath()
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            TabView {
                coordinator.build(page: .learningHomeView)
                    .tabItem { Text("학습") }
                coordinator.build(page: .prevProblemCategoryView)
                    .tabItem { Text("기출문제") }
                coordinator.build(page: .myPageView)
                    .tabItem { Text("마이페이지") }
            }
            .navigationDestination(for: Page.self) { page in
                coordinator.build(page: page)
            }
        }
        .onReceive(coordinator.$path) { navigationPath in
            self.navigationPath = navigationPath
        }
    }
}
