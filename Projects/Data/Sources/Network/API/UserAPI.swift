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
    case getUserInfo(id: String)
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
        case .getUserInfo(let id):
            return "/api/v1/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setProfileInfo:
            return .patch
        case .setNotiAcceptance:
            return .patch
        case .getUserInfo:
            return .get
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
        case .getUserInfo(let id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .setProfileInfo(let profileInfoDTO):
            return APIConfiguration.jsonContentType + ["Authorization": "Bearer \(profileInfoDTO.accessToken)"]
        case .setNotiAcceptance(let alarmAcceptanceDTO):
            return APIConfiguration.urlencodedContentType + ["Authorization": "Bearer \(alarmAcceptanceDTO.accessToken)"]
        case .getUserInfo:
            return nil
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
