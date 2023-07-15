//
//  ProfileRepository.swift
//  Data
//
//  Created by 김동락 on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Domain
import Combine
import UIKit

final public class DefaultProfileSettingRepository: ProfileSettingRepository {
    
    private let dataSource: ProfileSettingDataSource
    
    public init(dataSource: ProfileSettingDataSource) {
        self.dataSource = dataSource
    }
    
    public func postProfileInfo(profileInfoDTO: ProfileInfoDTO) -> AnyPublisher<Void, Error> {
        dataSource.postProfileInfo(profileInfoDTO: profileInfoDTO)
    }
    
    public func postProfileImage(profileImageDTO: ProfileImageDTO) -> AnyPublisher<Void, Error> {
        let compressedImage = compress(data: profileImageDTO.image, limit: 10000000)
        return dataSource.postProfileImage(profileImageDTO: ProfileImageDTO(image: compressedImage))
    }
    
    public func postAlarmAcceptance(alarmAcceptanceDTO: AlarmAcceptanceDTO) -> AnyPublisher<Void, Error> {
        dataSource.postAlarmAcceptance(alarmAcceptanceDTO: alarmAcceptanceDTO)
    }
    
    // 이미지 압축하기는 Data 영역에 Repository에서 처리
    // 하지만 압축을 위해서는 UIImage 함수가 필요한데, 이를 위해 Repository에서 UIKit을 Import 하는게 과연 맞는지?
    // 이럴 경우는 프레젠테이션 영역에서 처리해야할지?
    private func compress(data: Data, limit: Int) -> Data {
        var compressionQuality: CGFloat = 1.0
        if data.count > limit {
            compressionQuality = CGFloat(limit) / CGFloat(data.count)
        }
        return UIImage(data: data)?.jpegData(compressionQuality: compressionQuality) ?? Data()
    }
}
