//
//  noContentView.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/21.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct NoContentView: View {
    private let message: String
    private let withSymbol: Bool
    private let background: Color
    
    init(message: String, withSymbol: Bool = true, background: Color = .Bg_Light) {
        self.message = message
        self.withSymbol = withSymbol
        self.background = background
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            if withSymbol {
                Image(systemName: SymbolName.exclamationMark)
                    .font(.system(size: 54))
            }
            Text(message)
                .font(.Body1Regular)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.Text_Disabled)
        .background(background)
    }
}
