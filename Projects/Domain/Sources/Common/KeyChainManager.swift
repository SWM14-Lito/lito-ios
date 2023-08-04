//
//  KeyChainManager.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Security

final public class KeyChainManager {
    
    public enum UserKeys: String, CaseIterable {
        case userId
        case accessToken
        case refreshToken
    }

    static public func create(key: UserKeys, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(query)

        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    static public func create(key: UserKeys, token: Int) {
        let tokenStr = String(token)
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: tokenStr.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(query)

        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    static public func read(key: UserKeys) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
    static public func delete(key: UserKeys) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }

}

extension KeyChainManager {
    
    static public func createUserInfo(userAuthVO: UserAuthVO) {
        create(key: .accessToken, token: userAuthVO.accessToken)
        create(key: .refreshToken, token: userAuthVO.refreashToken)
        create(key: .userId, token: userAuthVO.userId)
    }
    
    static public func deleteUserInfo() {
        UserKeys.allCases.forEach { key in
            let query: NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key.rawValue
            ]
            let status = SecItemDelete(query)
            assert(status == noErr, "failed to delete the value, status code = \(status)")
        }
       
    }
    
    public static var isUserInfoExist: Bool {
        if KeyChainManager.read(key: .accessToken) == nil && KeyChainManager.read(key: .refreshToken) == nil && KeyChainManager.read(key: .userId) == nil {
            return false
        }
        return true
    }
    
}
