//
//  CustomNavigation.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct CustomNavigation: ViewModifier {
    var title: String
    var back: () -> Void
    var toolbarContent: SymbolButtonToolbar?
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: back, label: {
                        HStack {
                            Image(systemName: SymbolName.chevronLeft)
                                .foregroundColor(.Text_Default)
                                .font(.system(size: 22, weight: .regular))
                            Text(title)
                                .foregroundColor(.Text_Default)
                                .font(.Head1Bold)
                        }
                        .transaction { transaction in
                            transaction.animation = nil
                        }
                    })
                }
                if let toolbarContent = toolbarContent {
                    toolbarContent
                }
            }
    }
}

struct SymbolButtonToolbar: ToolbarContent {
    let placement: ToolbarItemPlacement
    let symbolName: String
    let action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: action, label: {
                Image(systemName: symbolName)
                    .foregroundColor(.Text_Default)
            })
        }
    }
}

extension View {
    
    func customNavigation(_ customNavigationModifier: CustomNavigation) -> some View {
        modifier(customNavigationModifier)
    }
    
}
