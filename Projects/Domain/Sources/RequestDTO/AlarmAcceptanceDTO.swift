//
//  AlarmAcceptanceDTO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

public struct AlarmAcceptanceDTO {
    public let getAlarm: Bool
    
    public init(getAlarm: Bool) {
        self.getAlarm = getAlarm
    }
}
