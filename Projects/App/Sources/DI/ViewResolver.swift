//
//  ViewResolver.swift
//  App
//
//  Created by 김동락 on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import Presentation

public class ViewResolver: ViewResolverProtocol {
    
    private var injector: Injector
    
    public init(injector: Injector) {
        self.injector = injector
    }
    
    public func resolveView<T>(_ serviceType: T.Type) -> T {
        return injector.resolve(T.self)
    }
}
