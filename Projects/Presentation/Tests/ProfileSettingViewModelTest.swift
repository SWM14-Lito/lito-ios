//
//  ProfileSettingViewModelTest.swift
//  PresentationTests
//
//  Created by 김동락 on 2023/10/05.
//  Copyright © 2023 com.lito. All rights reserved.
//

import XCTest
import Combine
@testable import Presentation
@testable import Domain

// MARK: UNUserNotificationCenter.current() 문제로 작동하지 않음
/*
class ProfileSettingViewModel_Test: BaseTestCase {
    var viewModel: ProfileSettingViewModel!
    
    /*
    <테스트 설명> 입력값에 특수문자가 포함되어있을 경우 원하는 에러메시지 잘 나오는지 테스트
    <가정> 유저네임에 "!" 포함, 닉네임은 정상 입력
    <원하는 결과값> textErrorMessage == "이름에 알파벳 또는 숫자만 써주세요"
     */
    func testUsernameContainingSpecialCharacter() throws {
        given {
            viewModel = ProfileSettingViewModel(
                userAuthVO: UserAuthVO.mock,
                useCase: MockProfileSettingUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.username.text = "ab!c"
            viewModel.nickname.text = "abc"
            viewModel.onFinishButtonClicked()
        }
        then {
            XCTAssertEqual(viewModel.textErrorMessage, "이름에 알파벳 또는 숫자만 써주세요")
        }
    }
    
    /*
    <테스트 설명> 입력값에 특수문자가 포함되어있을 경우 원하는 에러메시지 잘 나오는지 테스트
    <가정> 유저네임은 정상입력, 닉네임에 "_" 포함
    <원하는 결과값> textErrorMessage == "닉네임에 알파벳 또는 숫자만 써주세요"
     */
    func testNicknameContainingSpecialCharacter() throws {
        given {
            viewModel = ProfileSettingViewModel(
                userAuthVO: UserAuthVO.mock,
                useCase: MockProfileSettingUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.username.text = "abc"
            viewModel.nickname.text = "ab_c"
            viewModel.onFinishButtonClicked()
        }
        then {
            XCTAssertEqual(viewModel.textErrorMessage, "닉네임에 알파벳 또는 숫자만 써주세요")
        }
    }
    
    /*
    <테스트 설명> 입력값의 길이가 짧을 경우 원하는 에러메시지 잘 나오는지 테스트
    <가정> 유저네임 한 글자, 닉네임은 정상 입력
    <원하는 결과값> textErrorMessage == "이름은 2자 이상 작성해주세요."
     */
    func testUsernameShortLength() throws {
        given {
            viewModel = ProfileSettingViewModel(
                userAuthVO: UserAuthVO.mock,
                useCase: MockProfileSettingUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.username.text = "a"
            viewModel.nickname.text = "abc"
            viewModel.onFinishButtonClicked()
        }
        then {
            XCTAssertEqual(viewModel.textErrorMessage, "이름은 2자 이상 작성해주세요.")
        }
    }
    
    /*
    <테스트 설명> 입력값의 길이가 짧을 경우 원하는 에러메시지 잘 나오는지 테스트
    <가정> 유저네임 정상 입력, 닉네임은 한 글자
    <원하는 결과값> textErrorMessage == "닉네임은 2자 이상 작성해주세요."
     */
    func testNicknameShortLength() throws {
        given {
            viewModel = ProfileSettingViewModel(
                userAuthVO: UserAuthVO.mock,
                useCase: MockProfileSettingUseCase(),
                coordinator: MockCoordinator(),
                toastHelper: MockToastHelper()
            )
        }
        when {
            viewModel.username.text = "abc"
            viewModel.nickname.text = "a"
            viewModel.onFinishButtonClicked()
        }
        then {
            XCTAssertEqual(viewModel.textErrorMessage, "닉네임은 2자 이상 작성해주세요.")
        }
    }
}
*/
