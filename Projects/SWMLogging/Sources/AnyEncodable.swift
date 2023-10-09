//
//  AnyEncodable.swift
//  SWMLogging
//
//  Created by 김동락 on 2023/10/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

// 필요한 encodable 타입 추가 가능
public enum AnyEncodable: Encodable {
    case int(Int), string(String)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}
