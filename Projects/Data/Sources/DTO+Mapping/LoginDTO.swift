//
//  LoginDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain

public struct LoginDTO: Codable {
    
    let userId: Int
    let accessToken: String?
    let refresshToken: String?
    let registered: Bool?
    
    func toVO() -> LoginVO {
        return LoginVO(userId: userId , accessToken: accessToken ?? "Unknown", refresshToken: refresshToken ?? "Unknown", registered: registered ?? false)
    }
    
}
