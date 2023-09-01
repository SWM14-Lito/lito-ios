//
//  SolvingProblemViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain
import Combine

public final class SolvingProblemListViewModel: BaseViewModel {
    private let useCase: SolvingProblemListUseCase
    private let problemSize = 10
    private var problemPage = 0
    private var problemTotalSize: Int?
    @Published private(set) var isLoading: Bool = false
    @Published var problemCellList: [SolvingProblemCellVO] = []

    public init(useCase: SolvingProblemListUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }
    
    // 문제 리스트 가져오기
    public func onProblemListAppeared() {
        getProblemList()
    }
    
    // 무힌스크롤로 다음 문제 리스트 가져오기
    public func onProblemCellAppeared(id: Int) {
        getProblemList(problemUserId: id)
    }
    
    // 화면이 다시 떴을 때 혹시나 바뀌었을 값들을 위해 마지막으로 본 문제까지 전부 업데이트해주기
    public func onScreenAppeared() {
        if problemCellList.isEmpty {
            return
        }

        let problemsQueryDTO = SolvingProblemsQueryDTO(lastProblemUserId: nil, page: 0, size: problemCellList.count+1)
        useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResult({ result in
                switch result {
                case .success(let problemsListVO):
                    if let problemsCellVO = problemsListVO.problemsCellVO {
                        for idx in 0..<problemsCellVO.count {
                            self.problemCellList[idx] = problemsCellVO[idx]
                        }
                        if self.problemCellList.count > problemsCellVO.count {
                            self.problemCellList.removeLast(self.problemCellList.count-problemsCellVO.count)
                        }
                    }
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
            })
            .store(in: cancelBag)
    }
    
    // 문제 받아오기 (무한 스크롤)
    private func getProblemList(problemUserId: Int? = nil) {
        if !problemCellList.isEmpty {
            guard problemUserId == problemCellList.last?.problemUserId else { return }
        }
        if let totalSize = problemTotalSize, problemPage*problemSize >= totalSize {
            return
        }
        isLoading = true
        let problemsQueryDTO = SolvingProblemsQueryDTO(lastProblemUserId: problemUserId, page: problemPage, size: problemSize)
        useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResult({ result in
                switch result {
                case .success(let problemsListVO):
                    if let problemsCellVO = problemsListVO.problemsCellVO {
                        problemsCellVO.forEach({ problemCellVO in
                            self.problemCellList.append(problemCellVO)
                        })
                        self.problemPage += 1
                    }
                    self.problemTotalSize = problemsListVO.total
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
                self.isLoading = false
            })
            .store(in: cancelBag)
    }
}

extension SolvingProblemListViewModel: ProblemCellHandling {
    // 해당 문제 풀이 화면으로 이동하기
    public func onProblemCellClicked(id: Int) {
        coordinator.push(.problemDetailScene(id: id))
    }
    
    // 찜하기 or 찜해제하기
    public func onFavoriteClicked(id: Int) {
        useCase.toggleProblemFavorite(id: id)
            .receive(on: DispatchQueue.main)
            .sinkToResult { result in
                switch result {
                case .success(_):
                    let index = self.problemCellList.firstIndex(where: { $0.problemId == id})!
                    self.problemCellList[index].favorite.toggle()
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
}
