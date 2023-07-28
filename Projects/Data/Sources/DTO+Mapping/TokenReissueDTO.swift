//
//  TokenReissueDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/26.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct TokenReissueDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}
