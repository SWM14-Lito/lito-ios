//
//  ProblemListViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/19.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

final public class ProblemListViewModel: BaseViewModel {

    private let useCase: LearningHomeUseCase
    @Published var selectedSubject: SubjectInfo = .all
    @Published var showSheet = false
    @Published var selectedFilter: problemListFilter = .all
    @Published var selectedFilters: [problemListFilter] = []
    public var prevFilter: problemListFilter = .all

    public init(useCase: LearningHomeUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }

    public enum SubjectInfo: String, CaseIterable {
        case all = "전체"
        case operationSystem = "운영체제"
        case network = "네트워크"
        case database = "데이터베이스"
        case structure = "자료구조"
    }
    
    public enum problemListFilter: String, CaseIterable {
        case all = "전체"
        case unsolved = "풀지않음"
        case solved = "풀이완료"
    }
    
    public func storePrevFilter() {
        prevFilter = selectedFilter
    }

}
