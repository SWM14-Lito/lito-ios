//
//  UserAPI.swift
//  Data
//
//  Created by 김동락 on 2023/07/31.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Moya
import Domain
import Foundation

enum UserAPI {
    case setProfileInfo(ProfileInfoDTO)
    case setNotiAcceptance(AlarmAcceptanceDTO)
}
extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .setProfileInfo:
            return "/api/v1/users"
        case .setNotiAcceptance:
            return "/api/v1/users/notifications"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setProfileInfo:
            return .patch
        case .setNotiAcceptance:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .setProfileInfo(let profileInfoDTO):
            return .requestParameters( parameters: [
                "nickname": profileInfoDTO.nickname,
                "introduce": profileInfoDTO.introduce,
                "name": profileInfoDTO.name
            ], encoding: JSONEncoding.default)
        case .setNotiAcceptance(let alarmAcceptanceDTO):
            return .requestParameters(parameters: [
                "alarmStatus": alarmAcceptanceDTO.getAlarm ? "Y" : "N"
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .setProfileInfo:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)", "Content-type": "application/json;charset=UTF-8"]
        case .setNotiAcceptance:
            return ["Authorization": "Bearer \(NetworkConfiguration.authorization)", "Content-type": "application/x-www-form-urlencoded"]
        }
    }
}