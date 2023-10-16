//
//  ErrorVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/06/30.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation

public enum ErrorVO: Error {
    
    case retryableError(String? = nil)
    case fatalError
    case tokenExpired
    
    public var localizedString: String {
        switch self {
        case .retryableError(let serverErrorMessage):
            return serverErrorMessage ?? "" + "다시 시도 해주세요"
        case .fatalError:
            return "치명적 오류입니다. 빠른 시일 내 복구하겠습니다."
        case .tokenExpired:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요."
        }
    }
}
