//
//  UserInfoDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/08/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Domain

public struct UserInfoDTO: Decodable {
    let userId: Int?
    let profileImgUrl: String?
    let point: Int?
    let nickname: String?
    let name: String?
    let introduce: String?
    let alarmStatus: String?
    
    public func toVO() -> UserInfoVO {
        var convertedAlarmStatus = true
        switch self.alarmStatus {
        case "N":
            convertedAlarmStatus = false
        default:
            convertedAlarmStatus = true
        }
        return UserInfoVO(userId: userId ?? 0, profileImgUrl: profileImgUrl ?? "", point: point ?? 0, nickName: nickname ?? "Unknown", name: name ?? "Unknown", introduce: introduce ?? "Unknown", alarmStatus: convertedAlarmStatus)
    }
    
}
