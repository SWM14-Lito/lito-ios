//
//  ImageHelper.swift
//  Domain
//
//  Created by 김동락 on 2023/07/16.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public protocol ImageHelper {
    func compress(data: Data, limit: Int) -> Data
}
