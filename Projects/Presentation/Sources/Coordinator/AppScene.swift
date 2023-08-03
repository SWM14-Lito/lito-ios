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

public enum AppScene: Identifiable {
    case loginScene, profileSettingScene(userAuthVO: UserAuthVO)
    case rootTabScene
    case learningHomeScene, problemListScene, solvingProblemListScene, favoriteProblemListScene, problemDetailScene(id: Int), chattingScene, problemSearchScene
    case pedigreeListScene
    case myPageScene
    
    public var id: Self {
        return self
    }
    
}

extension AppScene: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .loginScene:
            hasher.combine(0)
        case let .profileSettingScene(userAuthVO):
            hasher.combine(1)
            hasher.combine(userAuthVO)
        case .rootTabScene:
            hasher.combine(2)
        case .learningHomeScene:
            hasher.combine(3)
        case .problemListScene:
            hasher.combine(4)
        case .solvingProblemListScene:
            hasher.combine(5)
        case .favoriteProblemListScene:
            hasher.combine(6)
        case let .problemDetailScene(id):
            hasher.combine(7)
            hasher.combine(id)
        case .chattingScene:
            hasher.combine(8)
        case .problemSearchScene:
            hasher.combine(9)
        case .pedigreeListScene:
            hasher.combine(10)
        case .myPageScene:
            hasher.combine(11)
        }
    }
    
    public static func == (lhs: AppScene, rhs: AppScene) -> Bool {
        switch (lhs, rhs) {
        case (.loginScene, .loginScene),
            (.rootTabScene, .rootTabScene),
            (.learningHomeScene, .learningHomeScene):
            // Add other cases here for the scenes that don't have associated values
            return true
        case let (.profileSettingScene(userAuthVO1), .profileSettingScene(userAuthVO2)):
            return userAuthVO1 == userAuthVO2
        case let (.problemDetailScene(id1), .problemDetailScene(id2)):
            return id1 == id2
            // Add other cases for the scenes with associated values
        default:
            return false
        }
    }
}
