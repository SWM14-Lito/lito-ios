//
//  LearningHomeAPI.swift
//  Data
//
//  Created by 김동락 on 2023/07/13.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Moya
import Domain
import Foundation

enum ProblemAPI {
    case learningHome
    case problemList(ProblemsQueryDTO)
    case solvingProblemList(SolvingProblemsQueryDTO)
    case favoriteProblemList(FavoriteProblemsQueryDTO)
    case problemDetail(id: Int)
    case favoriteToggle(id: Int)
    case enterProblem(id: Int)
    case submitAnswer(id: Int, keyword: String)
}
extension ProblemAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .learningHome:
            return "/api/v1/problems/users"
        case .problemList:
            return "/api/v1/problems"
        case .solvingProblemList:
            return "/api/v1/problems/process-status"
        case .favoriteProblemList:
            return "/api/v1/problems/favorites"
        case .problemDetail:
            return "/api/v1/problems/1"
        case .favoriteToggle:
            return "/api/v1/problems/1/favorites"
        case .enterProblem:
            return "/api/v1/problems/1"
        case .submitAnswer:
            return "/api/v1/problems/1/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .learningHome:
            return .get
        case .problemDetail:
            return .get
        case .problemList:
            return .get
        case .solvingProblemList:
            return .get
        case .favoriteProblemList:
            return .get
        case .favoriteToggle:
            return .patch
        case .enterProblem:
            return .post
        case .submitAnswer:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .learningHome:
            return .requestPlain
        case .problemList(let problemsQueryDTO):
            var parameters: [String: Any] = [:]
            if let lastProblemId = problemsQueryDTO.lastProblemId {
                parameters["lastProblemId"] = lastProblemId
            }
            if let subjectId = problemsQueryDTO.subjectId, subjectId != 0 {
                parameters["subjectId"] = subjectId
            }
            if let problemStatus = problemsQueryDTO.problemStatus, problemStatus != "" {
                parameters["problemStatus"] = problemStatus
            }
            if let query = problemsQueryDTO.query {
                parameters["query"] = query
            }
            if let size = problemsQueryDTO.size {
                parameters["size"] = size
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .solvingProblemList(let solvingProblemsQueryDTO):
            var parameters: [String: Any] = [:]
            if let lastProblemId = solvingProblemsQueryDTO.lastProblemUserId {
                parameters["lastProblemUserId"] = lastProblemId
            }
            if let size = solvingProblemsQueryDTO.size {
                parameters["size"] = size
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .favoriteProblemList(let favoriteProblemsQueryDTO):
            var parameters: [String: Any] = [:]
            if let lastProblemId = favoriteProblemsQueryDTO.lastFavoriteId {
                parameters["lastFavoriteId"] = lastProblemId
            }
            if let subjectId = favoriteProblemsQueryDTO.subjectId, subjectId != 0 {
                parameters["subjectId"] = subjectId
            }
            if let problemStatus = favoriteProblemsQueryDTO.problemStatus, problemStatus != "" {
                parameters["problemStatus"] = problemStatus
            }
            if let size = favoriteProblemsQueryDTO.size {
                parameters["size"] = size
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .problemDetail(let id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        case .favoriteToggle(let id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        case .enterProblem(let id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        case .submitAnswer(let id, let keyword):
            return .requestCompositeParameters(
                bodyParameters: [
                    "keyword": keyword
                ],
                bodyEncoding: JSONEncoding.default,
                urlParameters: [
                    "id": id
                ]
            )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .learningHome, .problemList, .solvingProblemList, .favoriteProblemList, .problemDetail, .favoriteToggle:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)"]
        case .enterProblem:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)", "Content-type": "application/x-www-form-urlencoded"]
        case .submitAnswer:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)", "Content-type": "application/json;charset=UTF-8"]
        }
    }
}
