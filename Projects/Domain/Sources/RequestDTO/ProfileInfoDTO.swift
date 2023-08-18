//
//  ProfileSettingVO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct ProfileInfoDTO {
    public let name: String?
    public let nickname: String?
    public let introduce: String?
    public let accessToken: String
    
    public init(name: String? = nil, nickname: String? = nil, introduce: String? = nil, accessToken: String) {
        self.name = name
        self.nickname = nickname
        self.introduce = introduce
        self.accessToken = accessToken
    }
}
