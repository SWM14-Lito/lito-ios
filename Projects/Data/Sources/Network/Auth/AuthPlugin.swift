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
        UserAPI.postUserInfo(ProfileInfoDTO(name: "", nickname: "", introduce: "", accessToken: "")).pathWithMethod,
        UserAPI.patchUserInfo(ProfileInfoDTO(accessToken: "")).pathWithMethod,
        UserAPI.setNotiAcceptance(AlarmAcceptanceDTO(getAlarm: false, accessToken: "")).pathWithMethod,
        FileAPI.setProfileImage(ProfileImageDTO(image: Data(), accessToken: "")).pathWithMethod,
        AuthAPI.appleLogin(appleVO: OAuth.AppleVO(userIdentifier: "", userEmail: "")).pathWithMethod,
        AuthAPI.kakaoLogin(kakaoVO: OAuth.KakaoVO(userIdentifier: "", userEmail: "")).pathWithMethod
    ]
    
    private let needAccessAndRefreashToken = [
        AuthAPI.logout.pathWithMethod
    ]
    
    private let needRefreashToken = [
        AuthAPI.reissueToken.pathWithMethod
    ]
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        let pathWithMethod = target.path + target.method.rawValue
        switch pathWithMethod {
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
