//
//  MoyaAuthPlugin.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/08/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya
import Combine
import Domain

struct AuthPlugin: PluginType {
    
    private let noNeedAuthorization = [
        UserAPI.getUserInfo(id: "0").path,
        UserAPI.setNotiAcceptance(AlarmAcceptanceDTO(getAlarm: false, accessToken: "")).path,
        
    ]
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        switch target.path {
        case "login":
            break
        case "logout":
            request.addValue(NetworkConfiguration.accessToken, forHTTPHeaderField: "Authorization")
            request.addValue(NetworkConfiguration.refreashToken, forHTTPHeaderField: "REFRESH_TOKEN")
        case "reissue":
            request.addValue(NetworkConfiguration.refreashToken, forHTTPHeaderField: "REFRESH_TOKEN")
        default:
            request.addValue(NetworkConfiguration.accessToken, forHTTPHeaderField: "Authorization")
        }
        print(request)
        return request
    }
    
}
