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
    private var selectedProblemId: Int = 0
    @Published var problemCellList: [DefaultProblemCellVO] = []
    @Published var selectedSubject: SubjectInfo = .all
    @Published var selectedFilters: [ProblemListFilter] = []

    public init(useCase: ProblemListUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    public func getProblemList(problemId: Int? = nil) {
        if !problemCellList.isEmpty {
            guard problemId == problemCellList.last?.problemId else { return }
        }
        if let totalSize = problemTotalSize, problemPage*problemSize >= totalSize {
            return
        }
        let problemsQueryDTO = ProblemsQueryDTO(subjectId: selectedSubject.query, problemStatus: selectedFilters.first?.query, page: problemPage, size: problemSize)
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
                        if case .tokenExpired = errorVO {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                self.popToRoot()
                            }
                        }
                    }
                }
            })
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
    
    func getProblemMutable() {
        if selectedProblemId == 0 {
            return
        }
        useCase.getProblemMutable(id: selectedProblemId)
            .sinkToResult { result in
                switch result {
                case .success(let problemMutableVO):
                    let index = self.problemCellList.firstIndex(where: { $0.problemId == self.selectedProblemId})!
                    self.problemCellList[index].favorite = problemMutableVO.favorite
                    self.problemCellList[index].problemStatus = problemMutableVO.problemStatus
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
                self.selectedProblemId = 0
            }
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
        selectedProblemId = id
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
