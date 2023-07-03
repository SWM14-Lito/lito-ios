//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

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
