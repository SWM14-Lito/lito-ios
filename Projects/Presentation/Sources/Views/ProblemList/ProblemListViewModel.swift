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
    
    private let useCase: ProblemListUseCase
    private let problemSize = 10
    private var problemPage = 0
    private var problemTotalSize: Int?
    @Published var problemCellList: [DefaultProblemCellVO] = []
    @Published var selectedSubject: SubjectInfo = .all
    @Published var selectedFilters: [ProblemListFilter] = []
    @Published var isLoading: Bool = false
    
    public init(useCase: ProblemListUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
    }
    
    // 문제 리스트 가져오기
    public func onProblemListAppeared() {
        lastNetworkAction = onProblemListAppeared
        getProblemList()
    }
    
    // 무힌스크롤로 다음 문제 리스트 가져오기
    public func onProblemCellAppeared(id: Int) {
        lastNetworkAction = { [weak self] in
            guard let self = self else { return }
            self.onProblemCellAppeared(id: id)
        }
        getProblemList(problemId: id)
    }
    
    // 검색 화면으로 이동하기
    public func onSearchButtonClicked() {
        coordinator.push(.problemSearchScene)
    }
    
    // 화면이 다시 떴을 때 혹시나 바뀌었을 값들을 위해 마지막으로 본 문제까지 전부 업데이트해주기
    public func onScreenAppeared() {
        lastNetworkAction = onScreenAppeared
        if problemCellList.isEmpty {
            return
        }
        let problemsQueryDTO = ProblemsQueryDTO(subjectId: selectedSubject.query, problemStatus: selectedFilters.first?.query, page: 0, size: problemCellList.count)
        useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResultWithErrorHandler({ problemsListVO in
                if let problemsCellVO = problemsListVO.problemsCellVO {
                    for idx in 0..<problemsCellVO.count {
                        self.problemCellList[idx] = problemsCellVO[idx]
                    }
                    if self.problemCellList.count > problemsCellVO.count {
                        self.problemCellList.removeLast(self.problemCellList.count-problemsCellVO.count)
                    }
                }
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    // 문제 리스트 초기화하기
    private func resetProblemCellList() {
        problemCellList.removeAll()
        problemPage = 0
        problemTotalSize = nil
    }
    
    // 문제 받아오기 (무한 스크롤)
    private func getProblemList(problemId: Int? = nil) {
        lastNetworkAction = { [weak self] in
            guard let self = self else { return }
            self.getProblemList(problemId: problemId)
        }
        if !problemCellList.isEmpty {
            guard problemId == problemCellList.last?.problemId else { return }
        }
        if let totalSize = problemTotalSize, problemPage*problemSize >= totalSize {
            return
        }
        isLoading = true
        let problemsQueryDTO = ProblemsQueryDTO(subjectId: selectedSubject.query, problemStatus: selectedFilters.first?.query, page: problemPage, size: problemSize)
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
}

extension ProblemListViewModel: FilterHandling {
    // 필터에 따라 새로운 문제 보여주기
    func onFilterChanged() {
        lastNetworkAction = onFilterChanged
        resetProblemCellList()
        getProblemList(problemId: nil)
    }
}

extension ProblemListViewModel: ProblemCellHandling {
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
                self.problemCellList[index].favorite.toggle()
            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
}
