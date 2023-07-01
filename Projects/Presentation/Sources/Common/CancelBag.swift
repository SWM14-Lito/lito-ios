//
//  CancelBag.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/06/21.
//  Copyright © 2023 Lito. All rights reserved.
//

import Foundation
import Combine

final public class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.removeAll()
    }
    
    func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        subscriptions.formUnion(cancellables())
    }
    
    @resultBuilder
    struct Builder {
        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
}

extension AnyCancellable {
    
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
