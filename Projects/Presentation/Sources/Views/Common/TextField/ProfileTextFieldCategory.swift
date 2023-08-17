//
//  TextFieldCategory.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/16.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

enum ProfileTextFieldCategory: Hashable {
    case username, nickname, introduce
    var limit: Int {
        switch self {
        case .username:
            return 10
        case .nickname:
            return 10
        case .introduce:
            return 250
        }
    }
    var title: String {
        switch self {
        case .username:
            return "이름"
        case .nickname:
            return "닉네임"
        case .introduce:
            return "소개말"
        }
    }
    var placeHolder: String {
        return title + "을 입력해주세요."
    }
    var errorMessage: String {
        return title + "을 입력하지 않으셨습니다."
    }
}
