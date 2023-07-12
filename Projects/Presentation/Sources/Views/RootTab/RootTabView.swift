//
//  RootTabView.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public struct RootTabView: View {
    
    let tab1: LearningHomeView
    let tab2: PrevProblemCategoryView
    let tab3: MyPageView
    
    public init(tab1: LearningHomeView, tab2: PrevProblemCategoryView, tab3: MyPageView) {
        self.tab1 = tab1
        self.tab2 = tab2
        self.tab3 = tab3
    }
    
    public var body: some View {
        TabView {
            tab1
                .tabItem { Text("학습") }
            tab2
                .tabItem { Text("기출문제") }
            tab3
                .tabItem { Text("마이페이지") }
        }
    }
}
