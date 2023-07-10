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
            case .clientFailureReson(let failureReason, let message):
                print(failureReason)
                return message ?? "no message"
            case .authFailureReason(let failureReason, let errorInfo):
                print(failureReason)
                return errorInfo.debugDescription
            case .apiFailureReason(let failureReason, let errorInfo):
                print(failureReason)
                return errorInfo.debugDescription
            case .commonError(let error):
                return error.localizedDescription
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
                return authorizationError.localizedDescription
            case .commonError(let error):
                return error.localizedDescription
            }
        }
    }
    
}
