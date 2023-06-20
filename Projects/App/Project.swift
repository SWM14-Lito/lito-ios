//
//  Projects.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2023/05/01.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "App",
    platform: .iOS,
    product: .app,
    dependencies: [
        .Projcet.Presentation,
        .Projcet.Domain,
        .Projcet.Data,
        .SPM.Kingfisher,
        .SPM.Swinject
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
