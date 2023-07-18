//
//  ProblemCellViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Foundation

public final class ProblemCellViewModel: BaseViewModel {
    
    private let useCase: ProblemCellUseCase
    @Published public var problemCellVO: ProblemCellVO?

    public init(useCase: ProblemCellUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    // 문제 화면으로 이동하기
    func moveToProblemView(id: Int) {
        print(id, "번 문제로 이동하기")
    }
    
    // 찜하기 or 해제하기
    func changeFavoriteStatus(id: Int) {
        problemCellVO?.favorite.toggle()
        print(id, "찜하기")
    }
}
