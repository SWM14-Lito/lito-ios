//
//  ImageHelper.swift
//  Presentation
//
//  Created by 김동락 on 2023/07/16.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Foundation
import UIKit

public class DefaultImageHelper: ImageHelper {
    
    public init() { }
    
    public func compress(data: Data, limit: Int) -> Data {
        var compressionQuality: CGFloat = 1.0
        if data.count > limit {
            compressionQuality = CGFloat(limit) / CGFloat(data.count)
        }
        return UIImage(data: data)?.jpegData(compressionQuality: compressionQuality) ?? Data()
    }
}
