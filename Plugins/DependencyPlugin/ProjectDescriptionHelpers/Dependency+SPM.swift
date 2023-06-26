//
//  Dependency+SPM.swift
//  DependencyPlugin
//
//  Created by Lee Myeonghwan on 2023/06/19.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}
x
public extension TargetDependency.SPM {
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Moya = TargetDependency.external(name: "Moya")
}
