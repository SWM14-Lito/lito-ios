//
//  Coordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import KakaoSDKAuth

public enum AppScene: Hashable, Identifiable {
    case loginScene, profileSettingScene
    case rootTabScene
    case learningHomeScene, problemListScene, solvingProblemListScene, favoriteProblemListScene, problemDetailScene(id: Int), chatGPTScene
    case pedigreeListScene
    case myPageScene
    
    public var id: Self {
        return self
    }
}
