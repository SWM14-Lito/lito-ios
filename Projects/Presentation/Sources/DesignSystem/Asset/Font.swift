//
//  Font.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/08.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

extension Font {
    
    // common
    /// size: 22
    static var Head1Bold: Font { Font(UIFont(name: "Pretendard-Bold", size: 22)!) }
    /// size: 22
    static var Head1Light: Font { Font(UIFont(name: "Pretendard-Light", size: 22)!) }
    /// size: 20
    static var Head2Bold: Font { Font(UIFont(name: "Pretendard-Bold", size: 20)!) }
    /// size: 18
    static var Head3SemiBold: Font { Font(UIFont(name: "Pretendard-SemiBold", size: 18)!) }
    /// size: 16
    static var Body1Bold: Font { Font(UIFont(name: "Pretendard-Bold", size: 16)!) }
    /// size: 16
    static var Body1SemiBold: Font { Font(UIFont(name: "Pretendard-SemiBold", size: 16)!) }
    /// size: 16
    static var Body1Regular: Font { Font(UIFont(name: "Pretendard-Regular", size: 16)!) }
    /// size: 16
    static var Body1Medium: Font { Font(UIFont(name: "Pretendard-Medium", size: 16)!) }
    /// size: 14
    static var Body2Regular: Font { Font(UIFont(name: "Pretendard-Regular", size: 14)!) }
    /// size: 14
    static var Body2SemiBold: Font { Font(UIFont(name: "Pretendard-SemiBold", size: 14)!) }
    /// size: 13
    static var Body3Regular: Font { Font(UIFont(name: "Pretendard-Regular", size: 13)!) }
    /// size: 12
    static var InfoRegular: Font { Font(UIFont(name: "Pretendard-Regular", size: 12)!) }
    
    // special
    /// size: 26
    static var ProgressBarSemiBold: Font { Font(UIFont(name: "Pretendard-SemiBold", size: 26)!) }
    /// size: 24
    static var SearchMagnifyingglass: Font { Font(UIFont(name: "Pretendard-SemiBold", size: 24)!) }
    
}

extension UIFont {
    
    static func registerFont(bundle: Bundle, fontName: String) {
        let fontURL = bundle.url(forResource: fontName, withExtension: "otf")
        var errorRef: Unmanaged<CFError>?
        guard let fontURL = fontURL else {
            print("Faild to find font URL")
            return
        }
        if CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, &errorRef) == false {
            print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
    
    public static func registerCommonFonts() {
        // 폰트 정보 (OTF 확장자)
        let fonts = [
            "Pretendard-Black",
            "Pretendard-Bold",
            "Pretendard-ExtraBold",
            "Pretendard-ExtraLight",
            "Pretendard-Light",
            "Pretendard-Medium",
            "Pretendard-Regular",
            "Pretendard-SemiBold",
            "Pretendard-Thin"
        ]
        // 폰트 등록하기.
        for font in fonts {
            // UIFont extension 으로 파일로 불러와서 등록시키기
            UIFont.registerFont(bundle: Bundle.module, fontName: font)
        }
    }
    
}
