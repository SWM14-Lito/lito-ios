//
//  Color.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/04.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public extension Color {

    /// hex: 3EC481
    static let Bg_ChatGPT = makeLitoColor(.Bg_ChatGPT)
    /// hex: F3F3F3
    static let Bg_Dark_Deep = makeLitoColor(.Bg_Dark_Deep)
    /// hex: F5F5F5
    static let Bg_Deep = makeLitoColor(.Bg_Deep)
    /// hex: EFEFEF
    static let Bg_Default = makeLitoColor(.Bg_Default)
    /// hex: FAFAFA
    static let Bg_Light = makeLitoColor(.Bg_Light)
    /// hex: F0F0F0
    static let Bg_Picker = makeLitoColor(.Bg_Picker)
    /// hex: F6F7FF
    static let Bg_Point_Light = makeLitoColor(.Bg_Point_Light)
    /// hex: 494AE2
    static let Bg_Point = makeLitoColor(.Bg_Point)
    /// hex: F6F7FF
    static let Bg_Soft_Blue = makeLitoColor(.Bg_Soft_Blue)
    /// hex: FFB526
    static let Bg_Yellow = makeLitoColor(.Bg_Yellow)
    /// hex: E0E0E0
    static let Border_Default = makeLitoColor(.Border_Default)
    /// hex: DEDEFF
    static let Border_Serve = makeLitoColor(.Border_Serve)
    /// hex: 494AE2
    static let Border_Strong = makeLitoColor(.Border_Strong)
    /// hex: F3F3F3
    static let Border_Light = makeLitoColor(.Border_Light)
    /// hex: 12A480
    static let Button_Dark_Green = makeLitoColor(.Button_Dark_Green)
    /// hex: 494AE2
    static let Button_Point = makeLitoColor(.Button_Point)
    /// hex: 7778FF
    static let Button_Point_Light = makeLitoColor(.Button_Point_light)
    /// hex: E24949
    static let Button_Red = makeLitoColor(.Button_Red)
    /// hex: E2E2E2
    static let Button_Tag_Default = makeLitoColor(.Button_Tag_Default)
    /// hex: A0A0A0
    static let Button_Negative = makeLitoColor(.Button_Negative)
    /// hex: E2E2E2
    static let Divider_Default = makeLitoColor(.Divider_Default)
    /// hex: A0A0A0
    static let Divider_Strong = makeLitoColor(.Divider_Strong)
    /// hex: 00D7F4
    static let Gradation_BottonTrailing = makeLitoColor(.Gradation_BottonTrailing)
    /// hex: 494AE2
    static let Gradation_TopLeading = makeLitoColor(.Gradation_TopLeading)
    /// hex: FFFFFF
    static let Heart_Clicked_Inner = makeLitoColor(.Heart_Clicked_Inner)
    /// hex: FF5B5B
    static let Heart_Clicked_Outer = makeLitoColor(.Heart_Clicked_Outer)
    /// hex: C6C6C6
    static let Heart_Unclicked_Inner = makeLitoColor(.Heart_Unclicked_Inner)
    /// hex: E2E2E2
    static let Heart_Unclicked_Outer = makeLitoColor(.Heart_Unclicked_Outer)
    /// hex: C6C6C6
    static let Icon_Default = makeLitoColor(.Icon_Default)
    /// hex: 444444
    static let Icon_Strong = makeLitoColor(.Icon_Strong)
    /// hex: BFBFBF
    static let Shadow_Default = makeLitoColor(.Shadow_Default)
    /// hex: 232527
    static let Text_Default = makeLitoColor(.Text_Default)
    /// hex: A0A0A0
    static let Text_Disabled = makeLitoColor(.Text_Disabled)
    /// hex: 777777
    static let Text_Info = makeLitoColor(.Text_Info)
    /// hex: 494AE2
    static let Text_Point = makeLitoColor(.Text_Point)
    /// hex: 444444
    static let Text_Serve = makeLitoColor(.Text_Serve)
    /// hex: DADAFF
    static let Text_Highlight = makeLitoColor(.Text_Highlight)
    /// hex: EEEEFF
    static let Text_Highlight_Light = makeLitoColor(.Text_Highlight_Light)
}

extension ShapeStyle where Self == Color {
    static var Bg_ChatGPT: Color { Color.Bg_ChatGPT }
    static var Bg_Dark_Deep: Color { Color.Bg_Dark_Deep }
    static var Bg_Deep: Color { Color.Bg_Deep }
    static var Bg_Default: Color { Color.Bg_Default }
    static var Bg_Light: Color { Color.Bg_Light }
    static var Bg_Picker: Color { Color.Bg_Picker }
    static var Bg_Point_Light: Color { Color.Bg_Point_Light }
    static var Bg_Point: Color { Color.Bg_Point }
    static var Bg_Soft_Blue: Color { Color.makeLitoColor(.Bg_Soft_Blue) }
    static var Bg_Yellow: Color { Color.makeLitoColor(.Bg_Yellow) }
    static var Border_Default: Color { Color.Border_Default }
    static var Border_Serve: Color { Color.Border_Serve }
    static var Border_Strong: Color { Color.Border_Strong }
    static var Border_Light: Color { Color.Border_Light }
    static var Button_Dark_Green: Color { Color.Button_Dark_Green }
    static var Button_Point: Color { Color.Button_Point }
    static var Button_Point_Light: Color { Color.Button_Point_Light }
    static var Button_Red: Color { Color.Button_Red }
    static var Button_Tag_Default: Color { Color.Button_Tag_Default }
    static var Button_Negative: Color { Color.Button_Negative }
    static var Divider_Default: Color { Color.makeLitoColor(.Divider_Default) }
    static var Divider_Strong: Color { Color.makeLitoColor(.Divider_Strong) }
    static var Gradation_BottonTrailing: Color { Color.makeLitoColor(.Gradation_BottonTrailing) }
    static var Gradation_TopLeading: Color { Color.makeLitoColor(.Gradation_TopLeading) }
    static var Heart_Clicked_Inner: Color { Color.makeLitoColor(.Heart_Clicked_Inner) }
    static var Heart_Clicked_Outer: Color { Color.makeLitoColor(.Heart_Clicked_Outer) }
    static var Heart_Unclicked_Inner: Color { Color.makeLitoColor(.Heart_Unclicked_Inner) }
    static var Heart_Unclicked_Outer: Color { Color.makeLitoColor(.Heart_Unclicked_Outer) }
    static var Icon_Default: Color { Color.makeLitoColor(.Icon_Default) }
    static var Icon_Strong: Color { Color.makeLitoColor(.Icon_Strong) }
    static var Shadow_Default: Color { Color.makeLitoColor(.Shadow_Default) }
    static var Text_Default: Color { Color.makeLitoColor(.Text_Default) }
    static var Text_Disabled: Color { Color.makeLitoColor(.Text_Disabled) }
    static var Text_Info: Color { Color.makeLitoColor(.Text_Info) }
    static var Text_Point: Color { Color.makeLitoColor(.Text_Point) }
    static var Text_Serve: Color { Color.makeLitoColor(.Text_Serve) }
}

extension Color {
    
    static func makeLitoColor(_ color: LitoColor) -> Color {
        return Color(color.rawValue, bundle: Bundle.module)
    }
    
    // Later when using darkmode
    static func appearanceColor(light: LitoColor, dark: LitoColor, scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return makeLitoColor(light)
        case .dark:
            return makeLitoColor(dark)
        @unknown default:
            return makeLitoColor(light)
        }
    }
    
}

public enum LitoColor: String {
    case Bg_ChatGPT
    case Bg_Dark_Deep
    case Bg_Deep
    case Bg_Default
    case Bg_Light
    case Bg_Picker
    case Bg_Point_Light
    case Bg_Point
    case Bg_Soft_Blue
    case Bg_Yellow
    case Border_Default
    case Border_Serve
    case Border_Strong
    case Border_Light
    case Button_Dark_Green
    case Button_Point
    case Button_Point_light
    case Button_Red
    case Button_Tag_Default
    case Button_Negative
    case Divider_Default
    case Divider_Strong
    case Gradation_BottonTrailing
    case Gradation_TopLeading
    case Heart_Clicked_Inner
    case Heart_Clicked_Outer
    case Heart_Unclicked_Inner
    case Heart_Unclicked_Outer
    case Icon_Default
    case Icon_Strong
    case Shadow_Default
    case Text_Default
    case Text_Disabled
    case Text_Info
    case Text_Point
    case Text_Serve
    case Text_Highlight
    case Text_Highlight_Light
}
