//
//  OAuthVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public enum OAuth {
    
    case apple(AppleVO)
    case kakao(KakaoVO)
    
    public struct AppleVO {
        public let userIdentifier: String
        public let userEmail: String?
        public let userName: String?
        
        public init(userIdentifier: String, userEmail: String?, userName: String? = nil) {
            self.userIdentifier = userIdentifier
            self.userEmail = userEmail
            self.userName = userName
        }
    }
    
    public struct KakaoVO {
        public let userIdentifier: String
        public let userEmail: String
        
        public init(userIdentifier: String, userEmail: String) {
            self.userIdentifier = userIdentifier
            self.userEmail = userEmail
        }
    }
    
}
