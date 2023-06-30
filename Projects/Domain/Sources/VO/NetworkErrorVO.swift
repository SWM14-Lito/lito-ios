//
//  ErrorVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/06/30.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation

public enum NetworkErrorVO: Error {
    
    case retryableError
    case fatalError
    
    public var localizedString: String {
        switch self {
        case .retryableError:
            return "일시적인 네트워크 오류입니다.\n다시 시도 해주세요"
        case .fatalError:
            return "치명적 오류입니다. 빠른 시일 내 복구하겠습니다."
        }
    }
    
}
