//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct RootTabView: View {
    
    private let viewResolver: ViewResolverProtocol
    
    public init(viewResolver: ViewResolverProtocol) {
        self.viewResolver = viewResolver
    }
    
    public var body: some View {
        TabView {
            viewResolver.resolveView(LearningHomeView.self)
                .tabItem { Text("학습") }
            viewResolver.resolveView(PrevProblemCategoryView.self)
                .tabItem { Text("기출문제") }
            viewResolver.resolveView(MyPageView.self)
                .tabItem { Text("마이페이지") }
        }
    }
}
