# lito-ios
개발직군 면접을 준비를 하는 것에 도움을 주기 위해 CS 문제를 제공해주는 서비스입니다.

## CleanArchitecture

![LitoCleanArchitecture-Layer drawio (1)](https://github.com/SWM14-Lito/lito-ios/assets/56781342/f50ae5cf-b578-4e1d-9540-db4c5b986dff)


    🎯 클린 아키텍쳐
    - 각각 분리된 계층의 역할과 책임이 명확해짐에 따라 코드 응집도가 높아짐.
    - 책임과 구조가 명확히 나눠져서 개발속도가 빨라지고, 테스트에 용이해짐.
    - 백엔드가 내려주는 데이터와 프론트엔드가 관심있는 데이터를 분리함으로써 서로의 관심사 분리가 쉬워짐. 
    - 부수적인 효과로 서버의 잘못된 response 에 대한 대응을 response DTO 와 VO 로 나눠서 앱의 안정성을 높일 수 있음.

- Presentation: UI 관련 로직 처리
- Domain: 비즈니스 로직을 처리
- Data: 데이터를 네트워킹을 통해 가져옴

<br/>

> ResponseDTO, ResponseVO
- 백엔드-프로트엔드의 데이터 관심사 분리를 위해서 Model을 ResponseVO 와 ResponseDTO 로 분리하고 각각 Domain 과 Data 에 나눔.
- 서버가 잘못된 응답을 줬을떄 앱의 crash를 막고 개발자가 빠르게 알아차리게 만들 수 있음.
- 반면 Request의 경우 VO와 DTO로 분리해서 처리하더라도 크게 이득을 얻을 수 있는 케이스는 현재 기획한 앱의 기능에서 없다고 판단하여 분리하지 않음.

<br/>

> MVVM + Combine
- Presentation, Domain, Data 전반의 비동기 처리를 Combine으로 구성.
- Presentation 을 view, viewModel로 나누고 데이터 publisher를 viewModel에 선언.
- viewModel 에서 바뀌는 데이터에 따라 view가 변경되도록 reactive programming 을 구현.

<br/>

## Modularization

![Untitled-3](https://github.com/SWM14-Lito/lito-ios/assets/56781342/bd5fc5f3-a623-4fb2-bec4-28e04f0971db)

    🎯 모듈화
    - 클린 아키텍처 설계에 따라 모듈 분리
    - 재활용성 및 확장성 향상
    - 빌드 속도 향상
    - 개발자의 실수를 미연에 방지해줌

> DI
- 설계한 CleanArchitecture 에 따라 DI 가 필수적으로 사용됨. (RepositoryProtocol 로 인한 의존성 역전)
- DI 를 적용할 때 ServiceLocator 의 역할을 쉽게 해줄 수 있는 Swinject 를 사용하였음

> Coordinator
- 화면간의 종속성을 제거하기 위해서 Coordinator 패턴 적용
- SwiftUI NavigationStack 을 활용하여 구현

<br/>

## 데이터 흐름 (Local Data Storage 사용 후)

## 에러 핸들링

![LitoCleanArchitecture-ErrorHandling 수정후 drawio](https://github.com/SWM14-Lito/lito-ios/assets/56781342/d4a31379-b9aa-481d-8f9c-091a9e453665)


    🎯 에러 핸들링
    - CleanArchitecture 가 계층간의 역할 분리가 명확하다는 이점을 고려하여 계층마다의 에러 관심사와 핸들링 분리.
    - Presentation, Domain 레이어와 Data 레이어가 사용하는 에러를 분리하였기 때문에 에러 케이스를 쉽게 확장, 변경 가능.
    - Presentation 에서 에러에 대응하는 view가 여러개일 수 있다는 것을 고려하여 ErrorView를 주입받아서 처리하도록 구현.

<br/>

> ErrorView 주입
- 내용 추가필요

## 로깅

## 유닛 테스트
    🎯 유닛테스트
    - 하나의 기능에 대해 독립적으로 테스트
    - 안정적으로 코드 변경 가능
    - 코드에 대한 일종의 문서 기능

> ViewModel 유닛 테스트
- 사용자의 동작에 따라 변한 특정 변수의 값이 예상한 값과 일치하는지 테스트
- 상위 객체와는 독립적으로 테스트 하기 위해 정해진 값을 바로 반환해주는 MockUseCase 주입

## 사용한 라이브러리
- Swinject: DI
- Moya: Network
- Combine: 비동기처리
- Kingfisher: 이미지처리
  
## 앱 스크린샷
|홈|문제 리스트|문제 풀이|
|:---:|:---:|:---:|
|<img width="250" src="https://github.com/SWM14-Lito/lito-ios/assets/72330884/72b7a847-f0c3-4a10-8983-152b59b0bab9">|<img width="250" src="https://github.com/SWM14-Lito/lito-ios/assets/72330884/41fc6669-abea-408c-8f82-9a42dd0f47cb">|<img width="250" src="https://github.com/SWM14-Lito/lito-ios/assets/72330884/6336ebe1-4101-4a64-9cc0-54e779a9df3f">|

|ChatGPT 질의응답|마이 페이지|
|:---:|:---:|
|<img width="250" src="https://github.com/SWM14-Lito/lito-ios/assets/72330884/ecbf34b9-f37b-4e32-8f80-e4c454c46ed9">|<img width="250" src="https://github.com/SWM14-Lito/lito-ios/assets/72330884/42e068d8-61a3-4987-b658-43c3678e3c59">|
