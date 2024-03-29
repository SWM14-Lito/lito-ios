//
//  ProfileTextField.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/16.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct profileTextField: View {
    
    private let fieldCategory: ProfileTextFieldCategory
    private let limitedText: Binding<LimitedText>
    private let focus: FocusState<ProfileTextFieldCategory?>?
    
    private var curLength: String {
        return String(limitedText.wrappedValue.text.count)
    }
    
    private var maxLength: String {
        return String(limitedText.wrappedValue.limit)
    }

    init(fieldCategory: ProfileTextFieldCategory, limitedText: Binding<LimitedText>, focus: FocusState<ProfileTextFieldCategory?>? = nil ) {
        self.fieldCategory = fieldCategory
        self.limitedText = limitedText
        self.focus = focus
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(fieldCategory.title)
                    .font(.Body2SemiBold)
                Spacer()
            }
            .padding(.bottom, 6)
            ZStack(alignment: .bottomTrailing) {
                HStack {
                    TextField(fieldCategory.placeHolder, text: limitedText.projectedValue.text, axis: fieldCategory == .introduce ? .vertical : .horizontal)
                        .font(.Body2Regular)
                        .if(fieldCategory == .introduce, transform: { view in
                            view
                                .lineLimit(3, reservesSpace: true)
                        })
                        .ifLet(focus, transform: { view, focus in
                            view
                                .focused(focus.projectedValue, equals: fieldCategory)
                        })
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.Border_Default, lineWidth: 1)
                )
                if fieldCategory != .introduce {
                    HStack {
                        Text(curLength + "/" + maxLength)
                            .font(.system(size: 10))
                            .foregroundColor(limitedText.wrappedValue.isReachedLimit ? .red : .black)
                        Image(systemName: SymbolName.xmarkCircleFill)
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                limitedText.projectedValue.text.wrappedValue = ""
                            }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                }
            }
        }
    }
}
