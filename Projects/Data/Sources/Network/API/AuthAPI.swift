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

enum AuthAPI {
    case appleLogin(appleVO: OAuth.AppleVO)
    case kakaoLogin(kakaoVO: OAuth.KakaoVO)
    case reissueToken
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
        case .reissueToken:
            return "/api/v1/auth/reissue"
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
        case .reissueToken:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .reissueToken:
            return ["Authorization": "Bearer \(NetworkConfiguration.refreashToken)", "Content-type": "application/x-www-form-urlencoded"]
        default:
            return AuthAPI.APICallHeaders.Json
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

extension AuthAPI {
    
    struct APICallHeaders {
        
        static let Json = ["Content-type": "application/json"]
        
    }
}
