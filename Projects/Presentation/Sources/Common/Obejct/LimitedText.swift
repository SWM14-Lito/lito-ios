//
//  LimitedText.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/04.
//  Copyright © 2023 Lito. All rights reserved.
//

import Combine

// 글자 제한 있는 텍스트
// - 사용 방법 -
// @ObservedObject private var nickname = LimitedText(limit: 10)
// TextField("", text: $nickname.text)

class LimitedText: ObservableObject {
    let limit: Int
    var isReachedLimit: Bool {
        return text.count == limit
    }
    
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
