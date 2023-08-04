//
//  FilterProtocol.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

// FilterView에 쓰는 enum 값 정의할 때 해당 프로토콜 따르도록 해야함
protocol FilterComponent: CaseIterable, Hashable {
    associatedtype T

    var name: String { get }
    static var allCases: [Self] { get }
    static var defaultValue: Self { get }
}

// FilterView 쓰는 ViewModel에서 해당 프로토콜 따르도록 해야함
protocol FilterHandling {
    func updateProblem()
}
