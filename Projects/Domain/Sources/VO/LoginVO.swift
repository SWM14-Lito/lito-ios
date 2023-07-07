//
//  LoginVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct LoginVO {
    
    let userId: Int
    let accessToken: String
    let refresshToken: String
    let registered: Bool
    
    public init(userId: Int, accessToken: String, refresshToken: String, registered: Bool) {
        self.userId = userId
        self.accessToken = accessToken
        self.refresshToken = refresshToken
        self.registered = registered
    }
    
}
