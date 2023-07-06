////
////  Receivable.swift
////  Presentation
////
////  Created by Lee Myeonghwan on 2023/07/04.
////  Copyright © 2023 com.lito. All rights reserved.
////

import Foundation
import SwiftUI
import Domain

public enum Feedbackable {
    
    case idle
    case feedback(String)
    case failed(ErrorVO)
    
    public var value: String? {
        switch self {
        case let .feedback(text): return text
        case let .failed(error): return error.localizedString
        default: return nil
        }
    }
}

extension Feedbackable {
    
    mutating func setIsIdle() {
        self = .idle
    }
    
}
