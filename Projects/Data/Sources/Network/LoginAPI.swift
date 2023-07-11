//
//  OAuthLoginAPI.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya
import Domain

enum LoginAPI {
    case apple(appleVO: OAuth.AppleVO)
    case kakao(kakaoVO: OAuth.KakaoVO)
}
extension LoginAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .apple:
            return "/api/auth/apple/login"
        case .kakao:
            return "/api/auth/kakao/login"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .apple(let appleVO):
            return .requestParameters(
                parameters: ["oauthId": appleVO.userIdentifier,
                             "email": appleVO.userEmail ?? ""
                            ], encoding: JSONEncoding.default)
        case .kakao(let kakaoVO):
            return .requestParameters(
                parameters: ["oauthId": kakaoVO.userIdentifier,
                             "email": kakaoVO.userEmail
                            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return LoginAPI.APICallHeaders.Json
    }
}

extension LoginAPI {
    
    struct APICallHeaders {
        
        static let Json = ["Content-type": "application/json"]
        
    }
}
