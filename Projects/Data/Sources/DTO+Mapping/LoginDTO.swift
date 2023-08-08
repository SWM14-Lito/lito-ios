//
//  LoginDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/08/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Domain

public struct LoginDTO: Decodable {
    let userId: Int
    let accessToken: String
    let refreshToken: String
    let refreshTokenExpirationTime: TimeInterval
    let registered: Bool
    
    public func toVO() -> LoginVO {
        let currentDate = Date()
        let expirationTimeInSeconds = refreshTokenExpirationTime / 1000
        let expirationDate = currentDate.addingTimeInterval(expirationTimeInSeconds)
        return LoginVO(userId: userId, accessToken: accessToken, refreshToken: refreshToken, registered: registered, refreshTokenExpirationTime: DateManager.shared.convertToString(from: expirationDate))
    }
    
}
