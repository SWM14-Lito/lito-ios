//
//  Image+.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/07/03.
//  Copyright © 2023 Lito. All rights reserved.
//

import SwiftUI

public extension Image {

    init(_ assetName: Asset) {
        self.init(assetName.rawValue, bundle: Bundle.module)
    }
}
