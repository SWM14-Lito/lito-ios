//
//  ProfileDTO.swift
//  Data
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct ProfileSettingDTO {
    let nickname: String?
    let profileImgUrl: String?
    let introduce: String?
    let name: String?
    
    func toVO() -> ProfileSettingVO {
        return ProfileSettingVO(nickname: nickname ?? "Unknown", profileImgUrl: profileImgUrl ?? "Unknown", introduce: introduce ?? "Unknown", name: name ?? "Unknown")
    }
}
