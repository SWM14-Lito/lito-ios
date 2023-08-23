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
    case postUserInfo(ProfileInfoDTO)
    case patchUserInfo(ProfileInfoDTO)
    case setNotiAcceptance(AlarmAcceptanceDTO)
    case getUserInfo(id: String)
    case deleteUser
}
extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConfiguration.developmentServerURL as! String)!
    }
    
    var path: String {
        switch self {
        case .postUserInfo, .patchUserInfo:
            return "/api/v1/users"
        case .setNotiAcceptance:
            return "/api/v1/users/notifications"
        case .getUserInfo(let id):
            return "/api/v1/users/\(id)"
        case .deleteUser:
            return "/api/v1/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postUserInfo:
            return .post
        case .patchUserInfo:
            return .patch
        case .setNotiAcceptance:
            return .patch
        case .getUserInfo:
            return .get
        case .deleteUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postUserInfo(let profileInfoDTO), .patchUserInfo(let profileInfoDTO):
            var parameters: [String: Any] = [:]
            if let name = profileInfoDTO.name {
                parameters["name"] = name
            }
            if let nickname = profileInfoDTO.nickname {
                parameters["nickname"] = nickname
            }
            if let introduce = profileInfoDTO.introduce {
                parameters["introduce"] = introduce
            }
            return .requestParameters( parameters: parameters, encoding: JSONEncoding.default)
        case .setNotiAcceptance(let alarmAcceptanceDTO):
            return .requestParameters(parameters: [
                "alarmStatus": alarmAcceptanceDTO.getAlarm ? "Y" : "N"
            ], encoding: URLEncoding.queryString)
        case .getUserInfo(let id):
            return .requestParameters(parameters: [
                "id": id
            ], encoding: URLEncoding.queryString)
        case .deleteUser:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postUserInfo(let profileInfoDTO), .patchUserInfo(let profileInfoDTO):
            return APIConfiguration.jsonContentType + ["Authorization": "Bearer \(profileInfoDTO.accessToken)"]
        case .setNotiAcceptance(let alarmAcceptanceDTO):
            return APIConfiguration.urlencodedContentType + ["Authorization": "Bearer \(alarmAcceptanceDTO.accessToken)"]
        default:
            return nil
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var pathWithMethod: String {
        return self.path + self.method.rawValue
    }
}
