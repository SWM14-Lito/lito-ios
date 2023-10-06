//
//  UserDefaultsManager.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/10/06.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

final public class UserDefaultsManager {
    
    public enum UserDefaultsKeys: String, CaseIterable {
        case problemGoalCount
        case recentKeywords
    }

    static public func set(key: UserDefaultsKeys, _ object: Any) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
    }
    
    static public func get(key: UserDefaultsKeys) -> Int {
        UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static public func get<T>(key: UserDefaultsKeys) -> [T] {
        UserDefaults.standard.array(forKey: key.rawValue) as? [T] ?? []
    }
    
    static public func delete(key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static public func deleteUserDefaults() {
        UserDefaultsKeys.allCases.forEach { key in
            UserDefaultsManager.delete(key: key)
        }
        
    }
    
}
