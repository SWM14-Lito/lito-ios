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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .learningHome:
            return .get
        case .problemList:
            return .get
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
            if let subjectId = problemsQueryDTO.subjectId {
                parameters["subjectId"] = subjectId
            }
            if let problemStatus = problemsQueryDTO.problemStatus {
                parameters["problemStatus"] = problemStatus
            }
            if let query = problemsQueryDTO.query {
                parameters["query"] = query
            }
            if let size = problemsQueryDTO.size {
                parameters["size"] = size
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .learningHome:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)"]
        case .problemList:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)"]
        }
    }
}
