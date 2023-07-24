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
    private var lastProblemId: Int?
    @Published var problemCellList: [ProblemCellVO] = []
    @Published var selectedSubject: SubjectInfo = .all
    @Published var showFilterSheet = false
    @Published var selectedFilter: ProblemListFilter = .all
    // TODO: 이후에 필터 view를 general 하게 사용하기 위한 변수
    @Published var selectedFilters: [ProblemListFilter] = []
    public var prevFilter: ProblemListFilter = .all
    private var isApply = false

    public init(useCase: ProblemListUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    public func getProblemList(problemId: Int? = nil) {
        if !problemCellList.isEmpty {
            guard problemId == problemCellList.last?.problemId else { return }
        }
        let problemsQueryDTO = ProblemsQueryDTO(lastProblemId: lastProblemId, subjectId: selectedSubject.number, problemStatus: selectedFilters.first?.number)
        useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResult({ result in
                switch result {
                case .success(let problemsCellVO):
                    problemsCellVO?.forEach({ problemCellVO in
                        self.lastProblemId = problemCellVO.problemId
                        self.problemCellList.append(problemCellVO)
                    })
                case .failure:
                    break
                }
            })
            .store(in: cancelBag)
    }
    
    private func resetProblemCellList() {
        problemCellList.removeAll()
        lastProblemId = nil
    }
    
    public func changeSubject(subject: SubjectInfo) {
        if selectedSubject != subject {
            selectedSubject = subject
            resetProblemCellList()
            getProblemList()
        }
    }
    
    public func filterSheetToggle() {
        showFilterSheet.toggle()
    }
    
    public func storePrevFilter() {
        prevFilter = selectedFilter
    }
    
    public func removeFilter(_ filter: ProblemListFilter) {
        if let index = selectedFilters.firstIndex(of: filter) {
            selectedFilters.remove(at: index)
            selectedFilter = .all
        }
        resetProblemCellList()
        getProblemList()
    }
    public func selectFilter(_ filter: ProblemListFilter) {
        if selectedFilter == filter {
            selectedFilter = .all
        } else {
            selectedFilter = filter
        }
    }
    public func applyFilter() {
        isApply = true
        showFilterSheet = false
        if selectedFilter != prevFilter {
            selectedFilters = [selectedFilter]
            resetProblemCellList()
            getProblemList()
        }
    }
    public func cancelSelectedFilter() {
        if !isApply {
            selectedFilter = prevFilter
        } else {
            isApply = false
        }
    }

}

extension ProblemListViewModel: ProblemCellHandling {
    
    public func moveToProblemView(id: Int) {
        coordinator.push(.problemSolvingScene(id: id))
    }
    
    public func changeFavoriteStatus(id: Int) {
        let index = problemCellList.firstIndex(where: { $0.problemId == id})!
        problemCellList[index].favorite.toggle()
        // TODO: API 통신
    }
    
}
