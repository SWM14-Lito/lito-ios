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

enum LearningHomeAPI {
    case getProfileAndProblems
}
extension LearningHomeAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .getProfileAndProblems:
            return "/api/problems/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfileAndProblems:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getProfileAndProblems:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getProfileAndProblems:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)"]
        }
    }
}
