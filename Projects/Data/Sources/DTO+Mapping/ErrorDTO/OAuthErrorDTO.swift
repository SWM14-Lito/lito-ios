//
//  OAuthErrorDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/05.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Domain

public enum OAuthErrorDTO: Error {
    
        case apple(Error)
        case kakao(Error)
    
        public var debugString: String {
            switch self {
            case .apple(let error):
                return "⛑️ Apple Login Error: \(error.localizedDescription) "
            case .kakao(let error):
                return "⛑️ Kakao Login Error: \(error.localizedDescription)"
            }
        }
    
    public func toVO() -> OAuthErrorVO {
        switch self {
        case .apple(_):
            // apple 에서 정의된 errorCode를 대조하여 error.localizedDescription에서 파싱하여 상황에 맞게 VO를 return?
            return OAuthErrorVO.internalServerError
        case .kakao(_):
            // kakao 에서 정의된 errorCode를 대조하여 error.localizedDescription에서 파싱하여 상황에 맞게 VO를 return?
            return OAuthErrorVO.internalServerError
        }
    }
}
