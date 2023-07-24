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
    @Published var selectedFilters: [ProblemListFilter] = []
    public var prevFilter: ProblemListFilter = .all
    @State private var isApply = false

    public init(useCase: ProblemListUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    public func getProblemList(problemId: Int? = nil) {
        if !problemCellList.isEmpty {
            guard problemId == problemCellList.last?.problemId else { return }
        }
        let problemsQueryDTO = ProblemsQueryDTO(lastProblemId: lastProblemId)
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
    
    public func filterSheetToggle() {
        showFilterSheet.toggle()
    }
    
    public func storePrevFilter() {
        prevFilter = selectedFilter
    }
    
    public func removeFilter(_ filter: ProblemListFilter) {
        if let index = selectedFilters.firstIndex(of: filter) {
            selectedFilters.remove(at: index)
        }
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
        selectedFilters = [selectedFilter]
        showFilterSheet = false
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
