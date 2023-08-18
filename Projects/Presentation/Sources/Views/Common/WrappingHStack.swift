//
//  WrappingHStack.swift
//  Presentation
//
//  Created by 김동락 on 2023/08/14.
//  Copyright © 2023 com.lito. All rights reserved.
//

// https://swiftui.diegolavalle.com/posts/linewrapping-stacks/

import SwiftUI

struct SizePref: PreferenceKey {
    static var defaultValue: CGSize = .init(width: 0, height: 0)
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct WHStack: View {
    private var verticalAlignment: VerticalAlignment
    private var horizontalAlignment: Alignment
    private var spacing: CGFloat
    private let content: [AnyView]
    @State private var height: CGFloat = 0

    init<Content: View>(verticalAlignment: VerticalAlignment = .center, horizontalAlignment: Alignment = .center, spacing: CGFloat = 8, content: () -> [Content]) {
        self.verticalAlignment = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.spacing = spacing
        self.content = content().map { AnyView($0) }
    }
    
    public var body: some View {
        GeometryReader { p in
            WrapStack(
                width: p.frame(in: .global).width,
                verticalAlignment: self.verticalAlignment,
                horizontalAlignment: self.horizontalAlignment,
                spacing: self.spacing,
                content: self.content
            )
            .anchorPreference(
                key: SizePref.self,
                value: .bounds,
                transform: {
                    p[$0].size
                }
            )
        }
        .frame(height: height)
        .onPreferenceChange(SizePref.self, perform: {
            self.height = $0.height
        })
    }
}

struct WrapStack<Content: View>: View {
    
    let width: CGFloat
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: Alignment
    let spacing: CGFloat
    let content: [Content]
    
    private let totalLanes: Int
    private let limits: [Int]
    
    init(width: CGFloat, verticalAlignment: VerticalAlignment, horizontalAlignment: Alignment, spacing: CGFloat, content: [Content]) {
        self.width = width
        self.verticalAlignment = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.spacing = spacing
        self.content = content
        (totalLanes, limits, _, _) = content.reduce((0, [], 0, width)) { (accum, item) -> (Int, [Int], Int, CGFloat) in
            var (lanesSoFar, limits, index, laneLength) = accum
            let itemSize = UIHostingController(rootView: item).view.intrinsicContentSize
            let itemLength = itemSize.width
            if laneLength + itemLength > width {
                lanesSoFar += 1
                laneLength = itemLength
                limits.append(index)
            } else {
                laneLength += itemLength + spacing
            }
            index += 1
            return (lanesSoFar, limits, index, laneLength)
        }
    }
    
    func lowerLimit(_ index: Int) -> Int {
        limits[index]
    }
    
    func upperLimit(_ index: Int) -> Int {
        if index == totalLanes - 1 {
            return content.count
        }
        return limits[index + 1]
    }
    
    func makeRow(_ i: Int) -> some View {
        HStack(alignment: verticalAlignment, spacing: spacing) {
            ForEach(self.lowerLimit(i) ..< self.upperLimit(i), id: \.self) {
                self.content[$0]
            }
        }
        .frame(maxWidth: .infinity, alignment: horizontalAlignment)
    }
    
    var lanes: some View {
        ForEach(0 ..< totalLanes, id: \.self) { i in
            Group {
                self.makeRow(i)
            }
        }
    }
    
    var body: some View {
        Group {
            VStack {
                lanes
            }
        }
    }
}
