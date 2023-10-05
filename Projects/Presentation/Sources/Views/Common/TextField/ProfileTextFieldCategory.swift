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
            return StringLiteral.username
        case .nickname:
            return StringLiteral.nickname
        case .introduce:
            return StringLiteral.introduce
        }
    }
    var placeHolder: String {
        return title + StringLiteral.profilePlaceHolder
    }
    var errorMessageForLength: String {
        return title + StringLiteral.profileErrorMessageForLength
    }
    var errrorMessageForSpecialCharacter: String {
        return title + StringLiteral.profileErrrorMessageForSpecialCharacter
    }
}
