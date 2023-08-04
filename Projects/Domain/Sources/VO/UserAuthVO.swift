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
    public let refreashToken: String
    public let userId: Int
    
    public init(accessToken: String, refreashToken: String, userId: Int) {
        self.accessToken = accessToken
        self.refreashToken = refreashToken
        self.userId = userId
    }
    
}
