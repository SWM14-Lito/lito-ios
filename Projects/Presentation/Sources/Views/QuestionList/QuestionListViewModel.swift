//
//  QuestionViewModel.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain

public class QuestionListViewModel: BaseViewModel {
    
    @Published private(set) var errorObject = ErrorObject()
    
    private let useCase: LearningHomeUseCase
    private let cancelBag = CancelBag()
    @Published var selectedSubject: SubjectInfo = .all
    
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
    
}
