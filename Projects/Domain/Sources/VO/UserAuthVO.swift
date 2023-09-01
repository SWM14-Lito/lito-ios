//
//  UserAuthVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/08/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct UserAuthVO: Hashable {
    public let accessToken: String
    public let refreshToken: String
    public let refreshTokenExpirationTime: String
    public let userId: Int
    public let userName: String
    
    public init(accessToken: String, refreashToken: String, refreshTokenExpirationTime: String, userId: Int, userName: String = "") {
        self.accessToken = accessToken
        self.refreshToken = refreashToken
        self.refreshTokenExpirationTime = refreshTokenExpirationTime
        self.userId = userId
        self.userName = userName
    }
}
