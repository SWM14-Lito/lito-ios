//
//  CustomNavigation.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/09.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct CustomNavigation: ViewModifier {
    let title: String
    let back: () -> Void
    var toolbarContent: SymbolButtonToolbar?
    var disabled: Binding<Bool>?

    init(title: String, back: @escaping () -> Void, toolbarContent: SymbolButtonToolbar? = nil, disabled: Binding<Bool>? = nil) {
        self.title = title
        self.back = back
        self.toolbarContent = toolbarContent
        self.disabled = disabled
        
        self.toolbarContent?.disabled = disabled
    }
    
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
                    .disabled(disabled?.wrappedValue ?? false)
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
    let color: Color
    let action: () -> Void
    var disabled: Binding<Bool>?
    
    init(placement: ToolbarItemPlacement, symbolName: String, color: Color = .Text_Default, action: @escaping () -> Void) {
        self.placement = placement
        self.symbolName = symbolName
        self.color = color
        self.action = action
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: action, label: {
                Image(systemName: symbolName)
                    .foregroundColor(color)
            })
            .disabled(disabled?.wrappedValue ?? false)
        }
    }
}

extension View {
    
    func customNavigation(_ customNavigationModifier: CustomNavigation) -> some View {
        modifier(customNavigationModifier)
    }
    
}
