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
}
