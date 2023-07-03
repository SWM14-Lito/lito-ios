//
//  APIService.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/27.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Moya

enum APIService {
    case oneSlip
}
extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .oneSlip:
            return URL(string: "https://api.adviceslip.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .oneSlip:
            return "advice"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oneSlip:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .oneSlip:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .oneSlip:
            return APIService.APICallHeaders.Json
        }
    }
    
}

extension APIService {
    
    struct APICallHeaders {
        
        static let Json = ["Accept": "application/json"]
        
    }
}
