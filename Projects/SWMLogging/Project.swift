//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2023/10/02.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "SWMLogging",
    product: .staticLibrary,
    dependencies: [
        .SPM.Moya,
        .SPM.CombineMoya
    ]
)
