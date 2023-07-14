//
//  IconExplanation.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/12.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct SymbolExplanationView: View {
    
    private let symbol: Symbol & Explanation
    
    init(symbol: Symbol & Explanation) {
        self.symbol = symbol
    }
    
    var body: some View {
        HStack {
            Image(systemName: symbol.symbolName)
            Text(symbol.explanation)
        }
        .font(.system(size: 12))
    }
}
