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
    @Published private(set) var recentKeywords: [String] = []
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
        $searchKeyword
            .sink { str in
                if str.count == 0 {
                    self.problemCellList.removeAll()
                    self.problemPage = 0
                    self.problemTotalSize = nil
                    self.searchState = .notStart
                }
            }
            .store(in: cancelBag)
    }
    
    // 무힌스크롤로 다음 문제 리스트 가져오기
    public func onProblemCellAppeared(id: Int) {
        getProblemList(problemId: id)
    }
    
    // 검색어 입력하면 해당되는 문제 보여주기
    public func onSearchKeywordSubmitted() {
        resetProblemCellList()
        getProblemList()
        recentKeywords.append(searchKeyword)
        useCase.setRecentKeywords(recentKeywords: recentKeywords)
    }
    
    // 화면이 다시 떴을 때 혹시나 바뀌었을 값들을 위해 마지막으로 본 문제까지 전부 업데이트해주기
    public func onScreenAppeared() {
        lastNetworkAction = onScreenAppeared
        recentKeywords = useCase.getRecentKeywords()
        if problemCellList.isEmpty {
            return
        }
        let problemsQueryDTO = SearchedProblemsQueryDTO(query: searchKeyword, page: 0, size: problemCellList.count)
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
    
    // 검색 다시 했을 때 초기화해주기
    private func resetProblemCellList() {
        searchState = .waiting
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
        let problemsQueryDTO = SearchedProblemsQueryDTO(query: searchKeyword, page: problemPage, size: problemSize)
        useCase.getProblemList(problemsQueryDTO: problemsQueryDTO)
            .sinkToResultWithErrorHandler({ problemsListVO in
                self.searchedKeyword = self.searchKeyword
                if let problemsCellVO = problemsListVO.problemsCellVO {
                    problemsCellVO.forEach({ problemCellVO in
                        self.problemCellList.append(problemCellVO)
                    })
                    self.problemPage += 1
                }
                self.problemTotalSize = problemsListVO.total
                self.searchState = .finish

            }, errorHandler: errorHandler)
            .store(in: cancelBag)
    }
    
    public func removeRecentKeywords() {
        recentKeywords = []
        useCase.setRecentKeywords(recentKeywords: recentKeywords)
    }
    
    public func searchRemoveButtonClicked() {
        searchKeyword = ""
    }
}

extension ProblemSearchViewModel: ProblemCellHandling {
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

extension ProblemSearchViewModel: RecentKeywordCellHandling {
    func searchWithRecentKeyword(keyword: String, index: Int) {
        searchKeyword = keyword
        resetProblemCellList()
        getProblemList()
        recentKeywords.remove(at: index)
        recentKeywords.append(searchKeyword)
        useCase.setRecentKeywords(recentKeywords: recentKeywords)
    }
    
    func deleteRecentKeyword(index: Int) {
        recentKeywords.remove(at: index)
        useCase.setRecentKeywords(recentKeywords: recentKeywords)
    }
}
