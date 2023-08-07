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
    let Bg_Deep = Color("Bg_Deep", bundle: Bundle.module)
    let Bg_Default = Color("Bg_Default", bundle: Bundle.module)
    let Bg_Light = Color("Bg_Light", bundle: Bundle.module)
    let Bg_Picker = Color("Bg_Picker", bundle: Bundle.module)
    let Border_Default = Color("Border_Default", bundle: Bundle.module)
    let Border_Serve = Color("Border_Serve", bundle: Bundle.module)
    let Border_Strong = Color("Border_Strong", bundle: Bundle.module)
    let Button_Point = Color("Button_Point", bundle: Bundle.module)
    let Divider_Default = Color("Divider_Default", bundle: Bundle.module)
    let Divider_Strong = Color("Divider_Strong", bundle: Bundle.module)
    let Gradation_BottonTrailing = Color("Gradation_BottonTrailing", bundle: Bundle.module)
    let Gradation_TopLeading = Color("Gradation_TopLeading", bundle: Bundle.module)
    let Heart_Clicked_Inner = Color("Heart_Clicked_Inner", bundle: Bundle.module)
    let Heart_Clicked_Outer = Color("Heart_Clicked_Outer", bundle: Bundle.module)
    let Heart_Unclicked_Inner = Color("Heart_Unclicked_Inner", bundle: Bundle.module)
    let Heart_Unclicked_Outer = Color("Heart_Unclicked_Outer", bundle: Bundle.module)
    let Shadow_Default = Color("Shadow_Default", bundle: Bundle.module)
    let Text_Default = Color("Text_Default", bundle: Bundle.module)
    let Text_Disabled = Color("Text_Disabled", bundle: Bundle.module)
    let Text_Info = Color("Text_Info", bundle: Bundle.module)
    let Text_Point = Color("Text_Point", bundle: Bundle.module)
    let Text_Serve = Color("Text_Serve", bundle: Bundle.module)
    let Text_White = Color("Text_White", bundle: Bundle.module)
}
