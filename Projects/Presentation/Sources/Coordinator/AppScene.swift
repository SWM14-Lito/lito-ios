//
//  Coordinator.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import KakaoSDKAuth
import Domain

public enum AppScene: Identifiable, Hashable {
    case loginScene, profileSettingScene(userAuthVO: UserAuthVO)
    case rootTabScene
    case learningHomeScene, problemListScene, solvingProblemListScene, favoriteProblemListScene, problemDetailScene(id: Int), chattingScene(question: String, answer: String), problemSearchScene
    case pedigreeListScene
    case myPageScene
    
    public var id: Self {
        return self
    }
    
}
