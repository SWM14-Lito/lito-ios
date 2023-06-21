//
//  SlipDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/06/20.
//  Copyright © 2023 Lito. All rights reserved.
//

import Domain

public struct Maxim: Codable {
    let slip: Slip
    
    func toSlip() -> SlipVO {
        return SlipVO(id: slip.id ?? 0, advice: slip.advice ?? "no advice")
    }
}

public struct Slip: Codable {
  var id     : Int?    = nil
  var advice : String? = nil
}
