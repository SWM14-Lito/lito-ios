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
    case setProfileInfo(ProfileInfoDTO)
    case setProfileImage(ProfileImageDTO)
    case setNotiAcceptance(AlarmAcceptanceDTO)
}
extension ProfileAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .setProfileInfo:
            return "/api/users"
        case .setProfileImage:
            return "/api/users"
        case .setNotiAcceptance:
            return "/api/users"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .setProfileInfo(let profileInfoDTO):
            return .requestParameters( parameters: [
                "nickname": profileInfoDTO.nickname,
                "introduce": profileInfoDTO.introduce,
                "name": profileInfoDTO.name
            ], encoding: JSONEncoding.default)
        case .setProfileImage(let profileImageDTO):
            let imgData = MultipartFormData(provider: .data(profileImageDTO.image), name: "file", fileName: "image.png", mimeType: "image/png")
            return .uploadMultipart([imgData])
        case .setNotiAcceptance(let alarmAcceptanceDTO):
            return .requestParameters(parameters: [
                "alarmStatus": alarmAcceptanceDTO.getAlarm
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
