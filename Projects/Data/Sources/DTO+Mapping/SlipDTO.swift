//
//  SlipDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Domain

public struct SlipDTO: Codable {
    let slip: Slip
    
    func toVO() -> SlipVO {
        return SlipVO(id: slip.id ?? 0, advice: slip.advice ?? "Unknown")
    }
}

public struct Slip: Codable {
    var id: Int?
    var advice: String?
}
