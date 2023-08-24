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
    public private (set) var problemTotalSize: Int?
    public private (set) var searchedKeyword = ""
    @Published private(set) var searchState: SearchState = .notStart
    @Published var searchKeyword: String = ""
    @Published var problemCellList: [DefaultProblemCellVO] = []
    
    public enum SearchState {
        case notStart
        case waiting
        case finish
    }
    
    public init(useCase: ProblemSearchUseCase, coordinator: CoordinatorProtocol, toastHelper: ToastHelperProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator, toastHelper: toastHelper)
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
    
    // 화면이 다시 떴을 때 혹시나 바뀌었을 값들을 위해 마지막으로 본 문제까지 전부 업데이트해주기
    func updateProblems() {
        if problemCellList.isEmpty {
            return
        }
        
        for page in 0...problemPage {
            let problemsQueryDTO = SearchedProblemsQueryDTO(query: searchKeyword, page: page, size: problemSize)
            useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
                .sinkToResult({ result in
                    switch result {
                    case .success(let problemsListVO):
                        if let problemsCellVO = problemsListVO.problemsCellVO {
                            for idx in 0..<problemsCellVO.count {
                                self.problemCellList[idx+page*self.problemSize] = problemsCellVO[idx]
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
}

extension ProblemSearchViewModel: ProblemCellHandling {
    // 해당 문제 풀이 화면으로 이동하기
    public func moveToProblemView(id: Int) {
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
