import SwiftUI
import Data
import Presentation
import Domain
import Swinject
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct LitoApp: App {
    private let injector: Injector
    
    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        injector = DependencyInjector(container: Container())
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly()
                          ])
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: injector.resolve(LoginViewModel.self)).onOpenURL(perform: { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
