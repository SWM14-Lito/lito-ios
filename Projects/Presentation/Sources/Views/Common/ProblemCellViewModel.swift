//
//  ProblemCellViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public final class ProblemCellViewModel: BaseViewModel, ObservableObject {
    
//    서버 통신 때 필요
//    private let useCase: ProblemCellUseCase
//
//    public init(useCase: ProblemCellUseCase, coordinator: CoordinatorProtocol) {
//        self.useCase = useCase
//        super.init(coordinator: coordinator)
//    }
    
    // 문제 화면으로 이동하기
    func moveToProblemView(id: Int) {
        print(id, "번 문제로 이동하기")
    }
    
    // 찜하기 or 해제하기
    func changeFavoriteStatus(id: Int) {
        print(id, "찜하기")
    }
}
