//
//  ToastHelperProtocol.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/22.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public protocol ToastHelperProtocol {
    func setMessage(_ message: String)
    func setDuration(_ time: Double)
    func showToast()
}
