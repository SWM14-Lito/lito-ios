//
//  ToogleStyle.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/08/11.
//  Copyright © 2023 com.lito. All rights reserved.
//

import SwiftUI

struct AlarmToggleStyle: ToggleStyle {
  private let width = 32.0
  private let height = 20.0
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()
      ZStack(alignment: configuration.isOn ? .trailing : .leading) {
        RoundedRectangle(cornerRadius: 22)
          .frame(width: width, height: height)
          .foregroundColor(configuration.isOn ? .Button_Point : .Icon_Default)
        
        RoundedRectangle(cornerRadius: 22)
          .frame(width: (width / 2) - 4, height: (width / 2 ) - 4 )
          .padding(4)
          .foregroundColor(.white)
          .onTapGesture {
            withAnimation {
              configuration.$isOn.wrappedValue.toggle()
            }
          }
      }
    }
  }
}
