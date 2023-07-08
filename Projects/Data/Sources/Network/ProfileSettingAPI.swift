//
//  ProfileSettingAPI.swift
//  Data
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Moya
import Domain
import Foundation

enum ProfileSettingAPI {
    case profile(profileSettingVO: ProfileSettingVO)
}
extension ProfileSettingAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .profile:
            return "/api/auth/apple/login"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .profile(let profileSettingVO):
            return .requestParameters(
                parameters: ["nickname": profileSettingVO.nickname,
                             "profileImgUrl": profileSettingVO.profileImgUrl,
                             "introduce": profileSettingVO.introduce,
                             "name": profileSettingVO.name
                            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return ProfileSettingAPI.APICallHeaders.Json
    }
}

extension ProfileSettingAPI {
    
    struct APICallHeaders {
        
        static let Json = ["Content-type": "application/json"]
        
    }
}
