//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2023/06/17.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Data",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projcet.Domain,
        .SPM.Moya,
        .SPM.CombineMoya,
        .SPM.KakaoOpenSDK
    ]
)
