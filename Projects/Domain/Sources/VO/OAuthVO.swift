//
//  OAuthVO.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public enum OAuth {
    
    public enum provider {
        case apple
        case kakao
    }
    
    public struct AppleVO {
        let provider = OAuth.provider.apple
        let userIdentifier: String
        let userName: String?
        let userEmail: String?
        
        public init(userIdentifier: String, userName: String?, userEmail: String?) {
            self.userIdentifier = userIdentifier
            self.userName = userName
            self.userEmail = userEmail
        }
    }
    
    public struct KakaoVO {
        let provider = OAuth.provider.kakao
        let userIdentifier: String
        let userEmail: String
        
        public init(userIdentifier: String, userEmail: String) {
            self.userIdentifier = userIdentifier
            self.userEmail = userEmail
        }
    }
    
}
