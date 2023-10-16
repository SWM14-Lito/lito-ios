//
//  SlipVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/06/19.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation

public struct SlipVO {
    public let id: Int
    public let advice: String
    
    public init(id: Int, advice: String) {
        self.id = id
        self.advice = advice
    }
    
}

extension SlipVO {
    static let mock = SlipVO(id: 0, advice: "Slip mock")
}
