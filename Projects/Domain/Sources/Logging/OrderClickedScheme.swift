//
//  OrderClickedScheme.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/10/02.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import SWMLogging

public struct OrderClickedScheme: ClickScheme {
    
    public var eventLogName = "missionClick"
    public var screenName = "SolvingProblemListView"
    public var logVersion = 1
    public var logData: [String: AnyEncodable] = [:]

    public init(userId: Int?, gender: String?, age: Int?) {
        
        // logData 만들기
        self.logData["userId"] = .int(userId ?? -1)
        self.logData["gender"] = .string(gender ?? "")
        self.logData["age"] = .int(age ?? -1)
        
    }
    
    public class Builder {
        var userId: Int?
        var gender: String?
        var age: Int?
        
        public init(userId: Int? = nil, gender: String? = nil, age: Int? = nil) {
            self.userId = userId
            self.gender = gender
            self.age = age
        }

        public func setGender(gender: String) -> Builder {
            self.gender = gender
            return self
        }
        public func setAge(age: Int) -> Builder {
            self.age = age
            return self
        }
        
        public func userId(id: Int) -> Builder {
            self.userId = id
            return self
        }

        public func build() -> SWMLoggingScheme {
            return OrderClickedScheme(userId: userId, gender: gender, age: age)
        }

    }

}
