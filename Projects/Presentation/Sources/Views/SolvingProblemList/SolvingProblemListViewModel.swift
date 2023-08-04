//
//  SolvingProblemViewModel.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI
import Domain
import Combine

public final class SolvingProblemListViewModel: BaseViewModel {
    private let useCase: SolvingProblemListUseCase
    private let problemSize = 10
    private var problemPage = 0
    private var problemTotalSize: Int?
    private var selectedProblemId: Int = 0
    @Published private(set) var isGotResponse: Bool = false
    @Published var problemCellList: [SolvingProblemCellVO] = []

    public init(useCase: SolvingProblemListUseCase, coordinator: CoordinatorProtocol) {
        self.useCase = useCase
        super.init(coordinator: coordinator)
    }

    // 문제 받아오기 (무한 스크롤)
    public func getProblemList(problemUserId: Int? = nil) {
        if !problemCellList.isEmpty {
            guard problemUserId == problemCellList.last?.problemUserId else { return }
        }
        if let totalSize = problemTotalSize, problemPage*problemSize >= totalSize {
            return
        }
        let problemsQueryDTO = SolvingProblemsQueryDTO(lastProblemUserId: problemUserId, page: problemPage, size: problemSize)
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
                        self.errorObject.error  = errorVO
                    }
                }
                self.isGotResponse = true
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
                    if !(problemMutableVO.problemStatus == .solving) {
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

extension SolvingProblemListViewModel: ProblemCellHandling {
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
