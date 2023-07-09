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

enum ProfileAPI {
    case setProfile(setProfileDTO: SetProfileDTO)
}
extension ProfileAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .setProfile:
            return "/api/users"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .setProfile(let profileInfoVO):

        // TODO: 이미지 데이터도 업로드 하기

            return .requestParameters(
                parameters: ["nickname": profileInfoVO.nickname,
                             "introduce": profileInfoVO.introduce,
                             "name": profileInfoVO.name
                            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return ProfileAPI.APICallHeaders.Json
    }
}

extension ProfileAPI {
    
    struct APICallHeaders {
        
        static let Json = ["Content-type": "application/json"]
        
    }
}
