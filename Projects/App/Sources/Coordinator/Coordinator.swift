//
//  AppCoordinator.swift
//  App
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI
import Presentation

public class Coordinator: ObservableObject, CoordinatorProtocol {
    @Published public var path = NavigationPath()
    public var pathPublisher: Published<NavigationPath>.Publisher { $path }
    public static let instance = Coordinator()
    
    public init() {
        
        print("init!!")
    }
    
    public func push(_ page: Page) {
        path.append(page)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
}
