//
//  Projects.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2023/05/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "App",
    platform: .iOS,
    product: .app,
    dependencies: [
        .project(target: "Home", path: .relativeToRoot("Projects/Home")),
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
