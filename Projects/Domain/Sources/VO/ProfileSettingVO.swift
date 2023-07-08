//
//  ProfileSettingVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct ProfileSettingVO {
    public let nickname: String
    public let profileImgUrl: String
    public let introduce: String
    public let name: String
    
    public init(nickname: String, profileImgUrl: String, introduce: String, name: String) {
        self.nickname = nickname
        self.profileImgUrl = profileImgUrl
        self.introduce = introduce
        self.name = name
    }
}
