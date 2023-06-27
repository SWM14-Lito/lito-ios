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

public extension TargetDependency.SPM {
    static let Kingfisher = TargetDependency.package(product: "Kingfisher")
    static let Swinject = TargetDependency.package(product: "Swinject")
    static let Moya = TargetDependency.package(product: "Moya")
    static let CombineMoya = TargetDependency.package(product: "CombineMoya")
}
