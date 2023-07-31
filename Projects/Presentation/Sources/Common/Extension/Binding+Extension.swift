//
//  Binding+Extension.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/25.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
    func toUnwrapped<T>() -> Binding<T> where Value == T? {
        Binding<T>(get: { self.wrappedValue! }, set: { self.wrappedValue = $0 })
    }
}
