//
//  ProfileImageDTO.swift
//  Domain
//
//  Created by 김동락 on 2023/07/10.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation

public struct ProfileImageDTO {
    public let image: Data
    
    public init(image: Data) {
        self.image = image
    }
}
