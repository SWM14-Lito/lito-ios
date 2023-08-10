//
//  ProblemSearchViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import SwiftUI

public class ProblemSearchViewModel: BaseViewModel {
    private let useCase: ProblemSearchUseCase
    private let problemSize = 10
    private var problemPage = 0
    private var problemTotalSize: Int?
    private var selectedProblemId: Int = 0
    @Published private(set) var searchState: SearchState = .notStart
    @Published var searchKeyword: String = ""
    public private (set) var searchedKeyword = ""
    @Published var problemCellList: [DefaultProblemCellVO] = []
    
    public enum SearchState {
        case notStart
        case waiting
        case finish
    }
    
    public init(useCase: ProblemSearchUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }
    
    // 검색 다시 했을 때 초기화해주기
    public func resetProblemCellList() {
        searchState = .waiting
        problemCellList.removeAll()
        problemPage = 0
        problemTotalSize = nil
    }

    // 문제 받아오기 (무한 스크롤)
    public func getProblemList(problemId: Int? = nil) {
        if !problemCellList.isEmpty {
            guard problemId == problemCellList.last?.problemId else { return }
        }
        if let totalSize = problemTotalSize, problemPage*problemSize >= totalSize {
            return
        }
        let problemsQueryDTO = SearchedProblemsQueryDTO(query: searchKeyword, page: problemPage, size: problemSize)
        useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResult({ result in
                switch result {
                case .success(let problemsListVO):
                    self.searchedKeyword = self.searchKeyword
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
                self.searchState = .finish
            })
            .store(in: cancelBag)
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

extension ProblemSearchViewModel: ProblemCellHandling {
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
