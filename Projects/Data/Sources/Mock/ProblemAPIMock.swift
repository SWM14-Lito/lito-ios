//
//  ProblemAPIMock.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/21.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

#if DEBUG

extension ProblemAPI {
    var sampleData: Data {
        switch self {
        case .learningHome:
            let dto = LearningHomeDTO(
                userId: 0,
                profileImgUrl: nil,
                nickname: "테스트",
                processProblem: ProblemCellDTO(
                    problemUserId: 1,
                    favoriteId: 1,
                    problemId: 1,
                    subjectName: "테스트",
                    question: "테스트",
                    problemStatus: "풀이완료",
                    favorite: false
                ),
                recommendProblems: [
                    ProblemCellDTO(
                        problemUserId: 1,
                        favoriteId: 1,
                        problemId: 1,
                        subjectName: "테스트",
                        question: "테스트",
                        problemStatus: "풀이완료",
                        favorite: false
                    ),
                    ProblemCellDTO(
                        problemUserId: 1,
                        favoriteId: 1,
                        problemId: 1,
                        subjectName: "테스트",
                        question: "테스트",
                        problemStatus: "풀이완료",
                        favorite: false
                    ),
                    ProblemCellDTO(
                        problemUserId: 1,
                        favoriteId: 1,
                        problemId: 1,
                        subjectName: "테스트",
                        question: "테스트",
                        problemStatus: "풀이완료",
                        favorite: false
                    )
                ], completeProblemCntInToday: 3
            )
            if let data = try? JSONEncoder().encode(dto) {
                return data
            } else {
                return Data()
            }
        case .problemList, .solvingProblemList, .favoriteProblemList, .searchedProblemList:
            let dto = ProblemListDTO(
                problems: [
                    ProblemCellDTO(
                        problemUserId: 1,
                        favoriteId: 1,
                        problemId: 1,
                        subjectName: "테스트",
                        question: "테스트",
                        problemStatus: "풀이완료",
                        favorite: false
                    ),
                    ProblemCellDTO(
                        problemUserId: 2,
                        favoriteId: 2,
                        problemId: 2,
                        subjectName: "테스트",
                        question: "테스트",
                        problemStatus: "풀이중",
                        favorite: true
                    )
                ],
                total: 2
            )
            if let data = try? JSONEncoder().encode(dto) {
                return data
            } else {
                return Data()
            }
        default:
            return Data()
        }
    }
}

#endif
