//
//  String+Extension.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/16.
//  Copyright © 2023 com.lito. All rights reserved.
//

extension String {
    subscript(index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)])
    }
    
    subscript(_ range: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let toIndex = self.index(self.startIndex, offsetBy: range.endIndex)
        return String(self[fromIndex..<toIndex])
    }
}
