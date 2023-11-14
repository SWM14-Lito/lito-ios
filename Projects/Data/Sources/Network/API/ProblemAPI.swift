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
    case searchedProblemList(SearchedProblemsQueryDTO)
    case solvingProblemList(SolvingProblemsQueryDTO)
    case favoriteProblemList(FavoriteProblemsQueryDTO)
    case wrongProblemList(WrongProblemQueryDTO)
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
        case .searchedProblemList:
            return "/api/v1/problems"
        case .solvingProblemList:
            return "/api/v1/problems/process-status"
        case .favoriteProblemList:
            return "/api/v1/problems/favorites"
        case .wrongProblemList:
            return "/api/v1/problems/reviews"
        case .problemDetail(let id):
            return "/api/v1/problems/" + String(id)
        case .favoriteToggle(let id):
            return "/api/v1/problems/" + String(id) + "/favorites"
        case .enterProblem(let id):
            return "/api/v1/problems/" + String(id)
        case .submitAnswer(let id, _):
            return "/api/v1/problems/" + String(id) + "/users"
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
        case .searchedProblemList:
            return .get
        case .solvingProblemList:
            return .get
        case .favoriteProblemList:
            return .get
        case .wrongProblemList:
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
            if let subjectId = problemsQueryDTO.subjectId, subjectId != 0 {
                parameters["subjectId"] = subjectId
            }
            if let problemStatus = problemsQueryDTO.problemStatus, problemStatus != "" {
                parameters["problemStatus"] = problemStatus
            }
            if let query = problemsQueryDTO.query {
                parameters["query"] = query
            }
            parameters["page"] = problemsQueryDTO.page
            parameters["size"] = problemsQueryDTO.size
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .searchedProblemList(let searchedProblemsQueryDTO):
            var parameters: [String: Any] = [:]
            parameters["query"] = searchedProblemsQueryDTO.query
            parameters["page"] = searchedProblemsQueryDTO.page
            parameters["size"] = searchedProblemsQueryDTO.size
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .solvingProblemList(let solvingProblemsQueryDTO):
            var parameters: [String: Any] = [:]
            if let lastProblemUserId = solvingProblemsQueryDTO.lastProblemUserId {
                parameters["lastProblemUserId"] = lastProblemUserId
            }
            parameters["page"] = solvingProblemsQueryDTO.page
            parameters["size"] = solvingProblemsQueryDTO.size
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
            parameters["page"] = favoriteProblemsQueryDTO.page
            parameters["size"] = favoriteProblemsQueryDTO.size
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .wrongProblemList(let wrongProblemsQueryDTO):
            var parameters: [String: Any] = [:]
            parameters["page"] = wrongProblemsQueryDTO.page
            parameters["size"] = wrongProblemsQueryDTO.size
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .problemDetail:
            return .requestPlain
        case .favoriteToggle:
            return .requestPlain
        case .enterProblem:
            return .requestPlain
        case .submitAnswer(_, let keyword):
            return .requestParameters(
                parameters: ["keyword": keyword],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .enterProblem:
            return APIConfiguration.urlencodedContentType
        case .submitAnswer:
            return APIConfiguration.jsonContentType
        default:
            return nil
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var pathWithMethod: String {
        return self.path + self.method.rawValue
    }
}
