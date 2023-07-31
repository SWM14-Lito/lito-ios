//
//  AuthAPI.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya
import Domain

enum AuthAPI {
    case appleLogin(appleVO: OAuth.AppleVO)
    case kakaoLogin(kakaoVO: OAuth.KakaoVO)
}
extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .appleLogin:
            return "/api/v1/auth/apple/login"
        case .kakaoLogin:
            return "/api/v1/auth/kakao/login"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .appleLogin(let appleVO):
            return .requestParameters(
                parameters: ["oauthId": appleVO.userIdentifier,
                             "email": appleVO.userEmail ?? ""
                            ], encoding: JSONEncoding.default)
        case .kakaoLogin(let kakaoVO):
            return .requestParameters(
                parameters: ["oauthId": kakaoVO.userIdentifier,
                             "email": kakaoVO.userEmail
                            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return AuthAPI.APICallHeaders.Json
    }
}

extension AuthAPI {
    
    struct APICallHeaders {
        
        static let Json = ["Content-type": "application/json"]
        
    }
}
