//
//  DateManager.swift
//  Domain
//
//  Created by Lee Myeonghwan on 2023/08/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

final public class DateManager {
    
    public static let shared = DateManager()
    
    private init() {}
    
    private let dateFormater: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormater.timeZone = TimeZone(identifier: "UTC")
        return dateFormater
    }()
    
    public func convertToString(from date: Date) -> String {
        return dateFormater.string(from: date)
    }
    
    public func convertToDate(from str: String) -> Date {
        return dateFormater.date(from: str)!
    }
    
}
