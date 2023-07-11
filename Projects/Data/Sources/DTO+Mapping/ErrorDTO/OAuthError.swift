//
//  OAuthErrorDTO.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/05.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Domain
import AuthenticationServices
import KakaoSDKCommon

public enum OAuthError {
    
    public enum kakaoDTO: Error {
        case clientFailureReson(ClientFailureReason, message: String?)
        case apiFailureReason(ApiFailureReason, ErrorInfo?)
        case authFailureReason(AuthFailureReason, AuthErrorInfo?)
        case commonError(Error)
        
        public var debugString: String {
            switch self {
            case .clientFailureReson(_, let message):
                return "🧐 " + (message ?? "no message")
            case .authFailureReason(_, let errorInfo):
                return "🧐 " + errorInfo.debugDescription
            case .apiFailureReason(_, let errorInfo):
                return "🧐 " + errorInfo.debugDescription
            case .commonError(let error):
                return "🧐 " + error.localizedDescription
            }
        }
        
        // TODO: VO로 어떻게 바꾸는게 좋을까?
        public func toVO() -> OAuthErrorVO {
            return OAuthErrorVO.internalServerError
        }
        
    }
    
    public enum appleErrorDTO: Error {
        case authorizationError(ASAuthorizationError)
        case commonError(Error)
        
        // TODO: VO로 어떻게 바꾸는게 좋을까?
        public func toVO() -> OAuthErrorVO {
//            switch authorizationError.code {
//            case .canceled:
//                break
//            case .
//            }
            return OAuthErrorVO.internalServerError
        }
        
        public var debugString: String {
            switch self {
            case .authorizationError(let authorizationError):
                switch authorizationError.code {
                case .canceled:
                    return "🧐 The user canceled the authorization attempt."
                case .failed:
                    return "🧐 The authorization attempt failed."
                case .invalidResponse:
                    return "🧐 The authorization request received an invalid response."
                case .notHandled:
                    return "🧐 The authorization request wasn’t handled."
                case .notInteractive:
                    return "🧐 The authorization request isn’t interactive."
                case .unknown:
                    return "🧐 The authorization attempt failed for an unknown reason."
                @unknown default:
                    return "🧐 Unknwon"
                }
            case .commonError(let error):
                return error.localizedDescription
            }
        }
    }
    
}
