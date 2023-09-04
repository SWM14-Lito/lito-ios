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

public enum OAuthErrorDTO {
    
    public enum kakao: Error {
        
        case clientFailureReason(ClientFailureReason, message: String?)
        case apiFailureReason(ApiFailureReason, ErrorInfo?)
        case authFailureReason(AuthFailureReason, AuthErrorInfo?)
        case commonError(Error)
        
        public var debugString: String {
            switch self {
            case .clientFailureReason(_, let message):
                return "🧐 " + (message ?? "no message")
            case .authFailureReason(_, let errorInfo):
                return "🧐 " + errorInfo.debugDescription
            case .apiFailureReason(_, let errorInfo):
                return "🧐 " + errorInfo.debugDescription
            case .commonError(let error):
                return "🧐 " + error.localizedDescription
            }
        }
        
        public func toVO() -> ErrorVO {
            switch self {
            case .apiFailureReason(_, _):
                return .fatalError
            case .authFailureReason(_, _):
                return .fatalError
            case .clientFailureReason(_, let message):
                return .retryableError(message)
            case .commonError(_):
                return .fatalError
            }
        }
        
    }
    
    public enum appleError: Error {
        case authorizationError(ASAuthorizationError)
        case commonError(Error)
        
        public func toVO() -> ErrorVO {
            switch self {
            case .authorizationError(let authorizationError):
                switch authorizationError.code {
                case .canceled:
                    return .retryableError("인증이 취소됐습니다.")
                case .failed:
                    return .fatalError
                case .invalidResponse:
                    return .fatalError
                case .notHandled:
                    return .fatalError
                case .notInteractive:
                    return .fatalError
                case .unknown:
                    return .fatalError
                @unknown default:
                    return .fatalError
                }
            case .commonError(_):
                return .retryableError("")
            }
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
