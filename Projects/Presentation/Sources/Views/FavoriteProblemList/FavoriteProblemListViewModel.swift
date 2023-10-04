//
//  FavoriteProblemListViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain
import Combine

public final class FavoriteProblemListViewModel: BaseViewModel {

    private let useCase: FavoriteProblemListUseCase
    private let problemSize = 10
    private var problemPage = 0
    private var problemTotalSize: Int?
    @Published var problemCellList: [FavoriteProblemCellVO] = []
    @Published var selectedSubject: SubjectInfo = .all
    @Published var selectedFilters: [ProblemListFilter] = []
    @Published var isLoading: Bool = false

    public init(useCase: FavoriteProblemListUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }
    
    // 문제 리스트 가져오기
    public func onProblemListAppeared() {
        getProblemList()
    }
    
    // 무힌스크롤로 다음 문제 리스트 가져오기
    public func onProblemCellAppeared(id: Int) {
        getProblemList(problemFavoriteId: id)
    }
    
    // 화면이 다시 떴을 때 혹시나 바뀌었을 값들을 위해 마지막으로 본 문제까지 전부 업데이트해주기
    public func onScreenAppeared() {
        lastNetworkAction = onScreenAppeared
        if problemCellList.isEmpty {
            return
        }
        
        let problemsQueryDTO = FavoriteProblemsQueryDTO(lastFavoriteId: nil, subjectId: selectedSubject.query, problemStatus: selectedFilters.first?.query, page: 0, size: problemCellList.count+1)
        
        self.useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResultWithErrorHandler({ problemsListVO in
                if let problemsCellVO = problemsListVO.problemsCellVO {
                    for idx in 0..<problemsCellVO.count {
                        self.problemCellList[idx] = problemsCellVO[idx]
                    }
                    if self.problemCellList.count > problemsCellVO.count {
                        self.problemCellList.removeLast(self.problemCellList.count-problemsCellVO.count)
                    }
                }
            }, errorHandler: self.errorHandler)
            .store(in: self.cancelBag)
    }
    
    // 문제 가져오기
    private func getProblemList(problemFavoriteId: Int? = nil) {
        lastNetworkAction = { [weak self] in
            guard let self = self else { return }
            self.getProblemList(problemFavoriteId: problemFavoriteId)
        }
        if !problemCellList.isEmpty {
            guard problemFavoriteId == problemCellList.last?.favoriteId else { return }
        }
        if let totalSize = problemTotalSize, problemPage*problemSize >= totalSize {
            return
        }
        isLoading = true
        let problemsQueryDTO = FavoriteProblemsQueryDTO(lastFavoriteId: problemFavoriteId, subjectId: selectedSubject.query, problemStatus: selectedFilters.first?.query, page: problemPage, size: problemSize)

        useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResultWithErrorHandler({ problemsListVO in
                if let problemsCellVO = problemsListVO.problemsCellVO {
                    problemsCellVO.forEach({ problemCellVO in
                        self.problemCellList.append(problemCellVO)
                    })
                    self.problemPage += 1
                }
                self.problemTotalSize = problemsListVO.total
                self.isLoading = false
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    // 기존 문제 목록 초기화하기
    private func resetProblemCellList() {
        problemCellList.removeAll()
        problemPage = 0
        problemTotalSize = nil
    }
}

extension FavoriteProblemListViewModel: FilterHandling {
    // 필터 업데이트되면 문제 목록 다시 받아오기
    func onFilterChanged() {
        lastNetworkAction = onFilterChanged
        resetProblemCellList()
        getProblemList(problemFavoriteId: nil)
    }
}

extension FavoriteProblemListViewModel: ProblemCellHandling {
    // 해당 문제 풀이 화면으로 이동하기
    public func onProblemCellClicked(id: Int) {
        coordinator.push(.problemDetailScene(id: id))
    }
    
    // 찜하기 or 찜해제하기
    public func onFavoriteClicked(id: Int) {
        lastNetworkAction = { [weak self] in
            guard let self = self else { return }
            self.onFavoriteClicked(id: id)
        }
        useCase.toggleProblemFavorite(id: id)
            .receive(on: DispatchQueue.main)
            .sinkToResultWithErrorHandler({ _ in
                let index = self.problemCellList.firstIndex(where: { $0.problemId == id})!
                self.problemCellList.remove(at: index)
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
}
