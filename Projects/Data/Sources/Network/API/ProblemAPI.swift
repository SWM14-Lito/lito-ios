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
    case problemDetail(id: Int)
    case favoriteToggle(id: Int)
}
extension ProblemAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .learningHome:
            return "/api/v1/problems/users"
        case .problemDetail:
            return "/api/v1/problems/1"
        case .favoriteToggle:
            return "/api/v1/problems/1/favorites"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .learningHome, .problemDetail:
            return .get
        case .favoriteToggle:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .learningHome:
            return .requestPlain
        case .problemDetail(let id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        case .favoriteToggle(let id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .learningHome, .problemDetail, .favoriteToggle:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)"]
        }
    }
}
