//
//  MockCoordinator.swift
//  PresentationTests
//
//  Created by 김동락 on 2023/09/16.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Presentation

public class MockCoordinator: CoordinatorProtocol {
    
    public var movedScene: [AppScene] = []
    
    public init() { }
    
    public func push(_ scene: Presentation.AppScene) {
        movedScene.append(scene)
    }
    
    public func pop() {
        
    }
    
    public func popToRoot() {
        
    }
    
    public func present(sheet: Presentation.AppScene) {
        
    }
    
    public func dismissSheet() {
        
    }
}
