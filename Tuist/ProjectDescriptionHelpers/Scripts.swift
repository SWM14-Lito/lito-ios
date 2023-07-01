//
//  Scripts.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2023/07/01.
//

import ProjectDescription

public extension TargetScript {
    static let SwiftLint = TargetScript.pre(script: """
if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint > /dev/null; then
    swiftlint
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
""", name: "SwiftLint", basedOnDependencyAnalysis: false)
}
