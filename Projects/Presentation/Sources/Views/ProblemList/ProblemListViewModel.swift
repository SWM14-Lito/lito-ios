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
    
    public func getProblemList(problemId: Int? = nil) {
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
    
    public func changeSubject(subject: SubjectInfo) {
        if selectedSubject != subject {
            selectedSubject = subject
            resetProblemCellList()
            getProblemList()
        }
    }
    
    public func moveToProblemSearchScene() {
        coordinator.push(.problemSearchScene)
    }
    
    private func resetProblemCellList() {
        problemCellList.removeAll()
        problemPage = 0
        problemTotalSize = nil
    }
    
    // 화면이 다시 떴을 때 혹시나 바뀌었을 값들을 위해 마지막으로 본 문제까지 전부 업데이트해주기
    func updateProblemValues() {
        if problemCellList.isEmpty {
            return
        }
        
        let problemsQueryDTO = ProblemsQueryDTO(subjectId: selectedSubject.query, problemStatus: selectedFilters.first?.query, page: 0, size: problemCellList.count)
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
}

extension ProblemListViewModel: FilterHandling {
    func updateProblem() {
        resetProblemCellList()
        getProblemList(problemId: nil)
    }
}

extension ProblemListViewModel: ProblemCellHandling {
    public func moveToProblemView(id: Int) {
        coordinator.push(.problemDetailScene(id: id))
    }
    
    public func changeFavoriteStatus(id: Int) {
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
