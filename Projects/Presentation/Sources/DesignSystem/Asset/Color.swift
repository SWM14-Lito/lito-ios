//
//  Color.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/04.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let mainBlue = Color("mainBlue", bundle: Bundle.module)
    let gray = Color("gray", bundle: Bundle.module)
    let white = Color("white", bundle: Bundle.module)
    let shadowGray = Color("shadowGray", bundle: Bundle.module)
    let background = Color("background", bundle: Bundle.module)
    let bookBlack = Color("bookBlack", bundle: Bundle.module)
    let heartRed = Color("heartRed", bundle: Bundle.module)
    let mainTextBlack = Color("mainTextBlack", bundle: Bundle.module)
    let subTitleGray = Color("subTitleGray", bundle: Bundle.module)
}
