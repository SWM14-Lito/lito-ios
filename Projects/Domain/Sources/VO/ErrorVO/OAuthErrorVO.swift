//
//  OAuthErrorVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public enum OAuthErrorVO: Error {
    
    case oauthServerError
    case internalServerError
    case cancelByUser
    
    public var debugString: String {
        switch self {
        case .oauthServerError:
            return "⛑️ oauthServerError"
        case .internalServerError:
            return "⛑️ internalServerError"
        case .cancelByUser:
            return "⛑️ cancelByUser"
        }
    }
}
