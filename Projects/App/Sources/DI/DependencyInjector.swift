//
//  DependencyInjector.swift
//  App
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Swinject

public protocol DependencyAssemblable {
    
    func assemble(_ assemblyList: [Assembly])
    func register<T>(_ serviceType: T.Type, _ object: T)
    
}

public protocol DependencyResolvable {
    
    func resolve<T>(_ serviceType: T.Type) -> T
    func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T
    func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments: Arg1, _ arg2: Arg2) -> T
    func resolve<T, Arg1, Arg2, Arg3>(_ serviceType: T.Type, arguments: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T
}

public typealias Injector = DependencyAssemblable & DependencyResolvable

public final class DependencyInjector: Injector {
    
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    public func assemble(_ assemblyList: [Assembly]) {
        assemblyList.forEach {
            $0.assemble(container: container)
        }
    }
    
    public func register<T>(_ serviceType: T.Type, _ object: T) {
        container.register(serviceType) { _ in object }
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        container.resolve(serviceType)!
    }
    
    public func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T {
        container.resolve(serviceType, argument: argument)!
    }
    
    public func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments: Arg1, _ arg2: Arg2) -> T {
        container.resolve(serviceType, arguments: arguments, arg2)!
    }
    
    public func resolve<T, Arg1, Arg2, Arg3>(_ serviceType: T.Type, arguments: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T {
        container.resolve(serviceType, arguments: arguments, arg2, arg3)!
    }
    
}
