//
//  MoyaAuthPlugin.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/08/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya
import Domain

struct AuthPlugin: PluginType {
    
    public static let shared = AuthPlugin()
    
    private init() {}
    
    private let noNeedAuthorization = [
        UserAPI.setProfileInfo(ProfileInfoDTO(name: "", nickname: "", introduce: "", accessToken: "")).path,
        UserAPI.setNotiAcceptance(AlarmAcceptanceDTO(getAlarm: false, accessToken: "")).path,
        FileAPI.setProfileImage(ProfileImageDTO(image: Data(), accessToken: "")).path,
        AuthAPI.appleLogin(appleVO: OAuth.AppleVO(userIdentifier: "", userEmail: "")).path,
        AuthAPI.kakaoLogin(kakaoVO: OAuth.KakaoVO(userIdentifier: "", userEmail: "")).path
    ]
    
    private let needAccessAndRefreashToken = [
        AuthAPI.logout.path
    ]
    
    private let needRefreashToken = [
        AuthAPI.reissueToken.path
    ]
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        switch target.path {
        case let path where noNeedAuthorization.contains(path):
            break
        case let path where needAccessAndRefreashToken.contains(path):
            request.headers.add(.authorization(bearerToken: NetworkConfiguration.accessToken))
            request.headers.add(name: "Refresh-Token", value: NetworkConfiguration.refreashToken)
        case let path where needRefreashToken.contains(path):
            request.headers.add(.authorization(bearerToken: NetworkConfiguration.refreashToken))
        default:
            request.headers.add(.authorization(bearerToken: NetworkConfiguration.accessToken))
        }
        return request
    }
    
}
