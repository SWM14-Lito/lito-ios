//
//  LimitedText.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/04.
//  Copyright © 2023 Lito. All rights reserved.
//

import Combine

class LimitedText: ObservableObject {
    let limit: Int
    
    @Published var text = "" {
        didSet {
            if text.count > limit && oldValue.count <= limit {
                text = oldValue
            }
        }
    }

    init(limit: Int) {
        self.limit = limit
    }
}
