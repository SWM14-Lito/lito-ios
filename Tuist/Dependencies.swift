//
//  Dependency.swift
//  Config
//
//  Created by Lee Myeonghwan on 2023/06/19.
//

import Foundation
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0")),
        .remote(url: "https://github.com/Swinject/Swinject", requirement: .upToNextMajor(from: "2.8.0")),
        .remote(url: "https://github.com/Swinject/Swinject", requirement: .upToNextMajor(from: "2.8.0")),
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0"))
    ],
    platforms: [.iOS]
)
