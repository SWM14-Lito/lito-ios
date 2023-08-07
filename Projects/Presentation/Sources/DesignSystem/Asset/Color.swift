//
//  Color.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/04.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

public extension Color {
    static let Bg_Default = makeLitoColor(.Bg_Default)
    static let Bg_Light = makeLitoColor(.Bg_Light)
    static let Bg_Picker = makeLitoColor(.Bg_Picker)
    static let Border_Default = makeLitoColor(.Border_Default)
    static let Border_Serve = makeLitoColor(.Border_Serve)
    static let Border_Strong = makeLitoColor(.Border_Strong)
    static let Button_Point = makeLitoColor(.Button_Point)
    static let Divider_Default = makeLitoColor(.Divider_Default)
    static let Divider_Strong = makeLitoColor(.Divider_Strong)
    static let Gradation_BottonTrailing = makeLitoColor(.Gradation_BottonTrailing)
    static let Gradation_TopLeading = makeLitoColor(.Gradation_TopLeading)
    static let Heart_Clicked_Inner = makeLitoColor(.Heart_Clicked_Inner)
    static let Heart_Clicked_Outer = makeLitoColor(.Heart_Clicked_Outer)
    static let Heart_Unclicked_Inner = makeLitoColor(.Heart_Unclicked_Inner)
    static let Heart_Unclicked_Outer = makeLitoColor(.Heart_Clicked_Outer)
    static let Shadow_Default = makeLitoColor(.Shadow_Default)
    static let Text_Default = makeLitoColor(.Text_Default)
    static let Text_Disabled = makeLitoColor(.Text_Disabled)
    static let Text_Info = makeLitoColor(.Text_Info)
    static let Text_Point = makeLitoColor(.Text_Point)
    static let Text_Serve = makeLitoColor(.Text_Serve)
    static let Text_White = makeLitoColor(.Text_White)
}

extension ShapeStyle where Self == Color {
    static var Bg_Default: Color { Color.makeLitoColor(.Bg_Default) }
    static var Bg_Light: Color { Color.makeLitoColor(.Bg_Light) }
    static var Bg_Picker: Color { Color.makeLitoColor(.Bg_Picker) }
    static var Border_Default: Color { Color.makeLitoColor(.Border_Default) }
    static var Border_Serve: Color { Color.makeLitoColor(.Border_Serve) }
    static var Border_Strong: Color { Color.makeLitoColor(.Border_Strong) }
    static var Button_Point: Color { Color.makeLitoColor(.Button_Point) }
    static var Divider_Default: Color { Color.makeLitoColor(.Divider_Default) }
    static var Divider_Strong: Color { Color.makeLitoColor(.Divider_Strong) }
    static var Gradation_BottonTrailing: Color { Color.makeLitoColor(.Gradation_BottonTrailing) }
    static var Gradation_TopLeading: Color { Color.makeLitoColor(.Gradation_TopLeading) }
    static var Heart_Clicked_Inner: Color { Color.makeLitoColor(.Heart_Clicked_Inner) }
    static var Heart_Clicked_Outer: Color { Color.makeLitoColor(.Heart_Clicked_Outer) }
    static var Heart_Unclicked_Inner: Color { Color.makeLitoColor(.Heart_Unclicked_Inner) }
    static var Heart_Unclicked_Outer: Color { Color.makeLitoColor(.Heart_Unclicked_Outer) }
    static var Shadow_Default: Color { Color.makeLitoColor(.Shadow_Default) }
    static var Text_Default: Color { Color.makeLitoColor(.Text_Default) }
    static var Text_Disabled: Color { Color.makeLitoColor(.Text_Disabled) }
    static var Text_Info: Color { Color.makeLitoColor(.Text_Info) }
    static var Text_Point: Color { Color.makeLitoColor(.Text_Point) }
    static var Text_Serve: Color { Color.makeLitoColor(.Text_Serve) }
    static var Text_White: Color { Color.makeLitoColor(.Text_White) }
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
    case Bg_Default
    case Bg_Light
    case Bg_Picker
    case Border_Default
    case Border_Serve
    case Border_Strong
    case Button_Point
    case Divider_Default
    case Divider_Strong
    case Gradation_BottonTrailing
    case Gradation_TopLeading
    case Heart_Clicked_Inner
    case Heart_Clicked_Outer
    case Heart_Unclicked_Inner
    case Heart_Unclicked_Outer
    case Shadow_Default
    case Text_Default
    case Text_Disabled
    case Text_Info
    case Text_Point
    case Text_Serve
    case Text_White
}
