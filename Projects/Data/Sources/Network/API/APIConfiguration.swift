//
//  APIConfiguration.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/08/08.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct APIConfiguration {
    static let jsonContentType = ["Content-type": "application/json;charset=UTF-8"]
    static let urlencodedContentType =  ["Content-type": "application/x-www-form-urlencoded"]
}

extension Dictionary {
    static func + (lhs: Dictionary, rhs: Dictionary) -> Dictionary {
        return lhs.merging(rhs) { (_, new) in new }
    }
}
