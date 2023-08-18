//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2023/05/01.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Presentation",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Projcet.Domain,
        .SPM.Kingfisher,
        .SPM.Lottie
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
