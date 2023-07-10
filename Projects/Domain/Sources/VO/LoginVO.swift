//
//  LoginVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct LoginVO: Decodable {
    
    let userId: Int
    let accessToken: String
    let refreshToken: String
    let registered: Bool
    
    public init(userId: Int, accessToken: String, refreshToken: String, registered: Bool) {
        self.userId = userId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.registered = registered
    }
    
}
