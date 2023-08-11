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
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.15.0")),
        .remote(url: "https://github.com/airbnb/lottie-spm.git", requirement: .upToNextMajor(from: "4.2.0"))
    ],
    platforms: [.iOS]
)
