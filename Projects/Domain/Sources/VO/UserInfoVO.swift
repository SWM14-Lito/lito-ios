//
//  UserInfoVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/08/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct UserInfoVO: Decodable {
    public let userId: Int
    public let profileImgUrl: String
    public let point: Int
    public let nickname: String
    public let name: String
    public let introduce: String
    public var alarmStatus: Bool
    
    public init(userId: Int, profileImgUrl: String, point: Int, nickName: String, name: String, introduce: String, alarmStatus: Bool) {
        self.userId = userId
        self.profileImgUrl = profileImgUrl
        self.point = point
        self.nickname = nickName
        self.name = name
        self.introduce = introduce
        self.alarmStatus = alarmStatus
    }
    
}
