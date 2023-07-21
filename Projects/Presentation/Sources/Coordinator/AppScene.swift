//
//  Coordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import KakaoSDKAuth

public enum AppScene: Hashable {
    case loginScene, profileSettingScene
    case rootTabScene
    case learningHomeScene, problemListScene, problemSolvingScene(id: Int)
    case pedigreeListScene
    case myPageScene
}
