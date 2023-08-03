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
    private var selectedProblemId: Int = 0
    @Published var problemCellList: [FavoriteProblemCellVO] = []
    @Published var selectedSubject: SubjectInfo = .all
    @Published var selectedFilters: [ProblemListFilter] = []

    public init(useCase: FavoriteProblemListUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    // 문제 가져오기
    public func getProblemList(problemFavoriteId: Int? = nil) {
        if !problemCellList.isEmpty {
            guard problemFavoriteId == problemCellList.last?.favoriteId else { return }
        }
        if let totalSize = problemTotalSize, problemPage*problemSize >= totalSize {
            return
        }
        let problemsQueryDTO = FavoriteProblemsQueryDTO(lastFavoriteId: problemFavoriteId, subjectId: selectedSubject.query, problemStatus: selectedFilters.first?.query, page: problemPage, size: problemSize)

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
    
    // 과목 바꾸기
    public func changeSubject(subject: SubjectInfo) {
        if selectedSubject != subject {
            selectedSubject = subject
            resetProblemCellList()
            getProblemList()
        }
    }
    
    // 기존 문제 목록 초기화하기
    private func resetProblemCellList() {
        problemCellList.removeAll()
        problemPage = 0
        problemTotalSize = nil
    }
    
    // 문제 풀이 화면으로 이동했다가 다시 돌아왔을 때 변할 가능성 있는 값 다시 받아오기
    func getProblemMutable() {
        if selectedProblemId == 0 {
            return
        }
        useCase.getProblemMutable(id: selectedProblemId)
            .sinkToResult { result in
                switch result {
                case .success(let problemMutableVO):
                    let index = self.problemCellList.firstIndex(where: { $0.problemId == self.selectedProblemId})!
                    self.problemCellList[index].problemStatus = problemMutableVO.problemStatus
                    if problemMutableVO.favorite == .notFavorite {
                        self.problemCellList.remove(at: index)
                    }
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

extension FavoriteProblemListViewModel: FilterHandling {
    // 필터 업데이트되면 문제 목록 다시 받아오기
    func updateProblem() {
        resetProblemCellList()
        getProblemList(problemFavoriteId: nil)
    }
}

extension FavoriteProblemListViewModel: ProblemCellHandling {
    // 해당 문제 풀이 화면으로 이동하기
    public func moveToProblemView(id: Int) {
        selectedProblemId = id
        coordinator.push(.problemDetailScene(id: id))
    }
    
    // 찜하기 or 찜해제하기
    public func changeFavoriteStatus(id: Int) {
        useCase.toggleProblemFavorite(id: id)
            .receive(on: DispatchQueue.main)
            .sinkToResult { result in
                switch result {
                case .success(_):
                    let index = self.problemCellList.firstIndex(where: { $0.problemId == id})!
                    self.problemCellList.remove(at: index)
                case .failure(let error):
                    if let errorVO = error as? ErrorVO {
                        self.errorObject.error  = errorVO
                    }
                }
            }
            .store(in: cancelBag)
    }
}
