//
//  MyPageEnum.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/01.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public enum MyPageList: String, CaseIterable, Hashable {
    case name = "이름"
    case nickName = "닉네임"
    case introduce = "소개말"
    case upload = "업로드한 기출문제"
    case purchase = "구매한 기출문제"
    case alarm = "알림 받기"
}
